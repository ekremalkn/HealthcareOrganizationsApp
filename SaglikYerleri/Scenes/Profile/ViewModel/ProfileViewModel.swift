//
//  ProfileViewModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 30.05.2023.
//

import RxSwift
import FirebaseAuth
import RevenueCat
import AuthenticationServices
import CryptoKit

enum ProfileButtonTableViewData: CaseIterable {
    case signOut
    case deleteAccount
    case restorePurchases
    
    var buttonTitle: String {
        switch self {
        case .signOut:
            return "Çıkış Yap"
        case .deleteAccount:
            return "Hesabını Sil"
        case .restorePurchases:
            return "Önceden satın aldığın premiumu etkinleştir"
        }
    }
}

final class ProfileViewModel {
    
    //MARK: - Dispose Bag
    private let disposeBag = DisposeBag()
    
    //MARK: - Customer Info Dictionary data for TableView
    let isUserInfoDataAvailable = PublishSubject<Bool>()
    let isPurchaseInfoDataAvailable = PublishSubject<Bool>()
    
    let purchaseInfoData = PublishSubject<[String : String]>()
    let userInfoData = PublishSubject<[String : String]>()
    
    let buttonData = Observable.just([
        ProfileButtonTableViewData.restorePurchases,
        ProfileButtonTableViewData.deleteAccount,
        ProfileButtonTableViewData.signOut,
    ])
    
    //MARK: - Referecenes
    let userService: UserService
    
    //MARK: - Current Nonce
    var currentNonce: String?
    
    //MARK: - Observables
    let didCompleteWithAuthorization = PublishSubject<ASAuthorization>()
    
    init(userService: UserService) {
        self.userService = userService
        subsToDidCompleteWithAuthorization()
    }
    
    func signOut(profileController: ProfileController) {
        userService.signOut().subscribe { [weak self] result in
            guard let self else { return }
            switch result {
            case .next():
                isUserInfoDataAvailable.onNext(false)
                isPurchaseInfoDataAvailable.onNext(false)
                profileController.showToast(message: "Çıkış işleminiz başarılı")
            case .error(let error):
                print("\(error) çıkış başarısız")
            case .completed:
                print("çıkış işlemi tamamlandı")
            }
            
        }.disposed(by: disposeBag)
    }
    
    //MARK: - When apple sign in complete with authorization
    private func subsToDidCompleteWithAuthorization() {
        didCompleteWithAuthorization.subscribe(onNext: { [weak self] authorization in
            guard let self else { return }
            guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential
            else {
                print("Unable to retrieve AppleIDCredential")
                return
            }
            
            guard let _ = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            
            guard let appleAuthCode = appleIDCredential.authorizationCode else {
                print("Unable to fetch authorization code")
                return
            }
            
            guard let authCodeString = String(data: appleAuthCode, encoding: .utf8) else {
                print("Unable to serialize auth code string from data: \(appleAuthCode.debugDescription)")
                return
            }
            
            Task {
                do {
                    try await Auth.auth().revokeToken(withAuthorizationCode: authCodeString)
                    try await Auth.auth().currentUser?.delete()
                    // silindi sayfayu yenilde
                    print("hesap silindi ")
                } catch {
                    print("hesap silinemedi: \(error)")
                }
            }
        }).disposed(by: disposeBag)
    }
    
    //MARK: - Delete curren apple user
    func deleteCurrentAppleUser(completion: (ASAuthorizationAppleIDRequest) -> Void) {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        completion(request)
        
        // In the unlikely case that nonce generation fails, show error view.
    }
    
    
    //MARK: - generate a random string a nonce
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            fatalError(
                "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
        }
        
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        
        let nonce = randomBytes.map { byte in
            // Pick a random character from the set, wrapping around if needed.
            charset[Int(byte) % charset.count]
        }
        
        return String(nonce)
    }
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    
}

//MARK: - Check Subscription Status
extension ProfileViewModel {
    
    func getUserInfo() {
        checkIsCurrentUserActive().flatMap { user in
            return Observable.just(user)
        }.subscribe(onNext: { [weak self] currentUser in
            guard let self else { return }
            var userDictionaryData: [String : String] = [ : ]
            
            if let currentUser {
                isUserInfoDataAvailable.onNext(true)
                let userName = currentUser.displayName ?? "Kullanıcı adı yok"
                let userEmail = currentUser.email ?? "Kullanıcı E-mailine ulaşılamadı"
                
                userDictionaryData["Kullanıcı Adı"] = userName
                userDictionaryData["Kullanıcı E-maili"] = userEmail
                
                userInfoData.onNext(userDictionaryData)
                
            } else {
                isUserInfoDataAvailable.onNext(false)
                
            }
            
        }).disposed(by: disposeBag)
    }
    
    func getCustomerPurchaseInfo() {
        checkIsCurrentUserActive().flatMap { user in
            return Observable.just(user)
        }.subscribe(onNext: { [unowned self] user in
            if user != nil { // Check if user already sign in with provider and has account on firebase
                isPurchaseInfoDataAvailable.onNext(true)
                IAPManager.shared.getCustomerInfo().subscribe { [weak self] customerInfo in
                    guard let self else { return }
                    switch customerInfo {
                    case .next(let customerInfo):
                        createDictionaryDataForTableView(customerInfo: customerInfo)
                    case .error(let error):
                        print(error.localizedDescription)
                    case .completed:
                        print("customer info alma işlemi tamamlandı")
                    }
                }.disposed(by: self.disposeBag)
            } else { // Check if user did not sign in with provider and has not account on firebase
                isPurchaseInfoDataAvailable.onNext(false)
            }
        }).disposed(by: disposeBag)
        
        
    }
    
    private func checkIsCurrentUserActive() -> Observable<User?> {
        return Observable.create { observer in
            if let currentUser = Auth.auth().currentUser {
                observer.onNext(currentUser)
            } else {
                observer.onNext(nil)
            }
            return Disposables.create()
        }
    }
    
    private func createDictionaryDataForTableView(customerInfo: CustomerInfo) {
        var purchaseDictionaryData: [String: String] = [:]
        
        if let entitlement = customerInfo.entitlements.all[IAPConstants.entitlementIdentifier.rawValue], entitlement.isActive {
            purchaseDictionaryData["Abonelik Durumu"] = "Aktif"
            
            switch entitlement.productIdentifier {
            case IAPConstants.monthlyProduct.rawValue:
                purchaseDictionaryData["Abonelik Türü"] = "Premimum Aylık"
            case IAPConstants.annualProduct.rawValue:
                purchaseDictionaryData["Abonelik Türü"] = "Premimum Yıllık"
            default:
                break
            }
            
            if let purchaseDate = entitlement.latestPurchaseDate {
                purchaseDictionaryData["Abonelik Başlangıcı"] = purchaseDate.formattedDateString()
            }
            
            if let expirationDate = customerInfo.entitlements[IAPConstants.entitlementIdentifier.rawValue]?.expirationDate {
                purchaseDictionaryData["Abonelik Bitişi"] = expirationDate.formattedDateString()
            }
        } else {
            purchaseDictionaryData["Abonelik Durumu"] = "Aktif Değil"
        }
        
        purchaseInfoData.onNext(purchaseDictionaryData)
        
        
        
    }
}


/*
 Abonelik Durumu: Aktif
 Abonelik Türü: revenucat entitlemets içerisinden premimum içerisinden product_identifieri al ya da revenucat entitlemets içerisinden premimum içerisinden subscriptionsu al
 Abone Emaili: googledan emaili çek yazdır
 Abone başlangıcı: revenucat entitlemets içerisinden premimum içerisinden purchase_datei al
 abne bitişi: revenucat entitlemets içerisinden premimum içerisinden  expires datei al
 
 
 */
