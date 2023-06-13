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

enum ProviderType: String {
    case apple = "apple.com"
    case google = "google.com"
}



enum ProfileButtonTableViewData {
    case signIn(isUserSignedIn: Bool)
    case signOut(isUserSignedIn: Bool)
    case deleteAccount(isUserSignedIn: Bool)
    case restorePurchases(isUserSignedIn: Bool)
    
    var buttonOption: (buttonTitle: String, buttonInteraction: Bool, buttonTintColor: String) {
        switch self {
        case .signIn(isUserSignedIn: let isUserSignedIn):
            switch isUserSignedIn {
            case true:
                return ("Giriş Yap", true, "056DFA")
            case false:
                return ("Giriş Yap", false, "8E8E93")
            }
        case .signOut(isUserSignedIn: let isUserSignedIn):
            switch isUserSignedIn {
            case true:
                return ("Çıkış Yap", true, "FF342B")
            case false:
                return ("Çıkış Yap", false, "8E8E93")
            }
        case .deleteAccount(isUserSignedIn: let isUserSignedIn):
            switch isUserSignedIn {
            case true:
                return ("Hesabını Sil", true, "FF342B")
            case false:
                return ("Hesabını Sil", false, "8E8E93")
            }
        case .restorePurchases(isUserSignedIn: let isUserSignedIn):
            switch isUserSignedIn {
            case true:
                return ("Hesabını etkinleştir" , true, "056DFA")
            case false:
                return ("Hesabını etkinleştir" , false, "8E8E93")
            }
        }
    }
    
}

final class ProfileViewModel {
    deinit {
        print("ProfileViewModel  deinit")
    }
    //MARK: - Dispose Bag
    private let disposeBag = DisposeBag()
    
    //MARK: - Customer Info Dictionary data for TableView
    let isUserInfoDataAvailable = PublishSubject<Bool>()
    let isPurchaseInfoDataAvailable = PublishSubject<Bool>()
    
    let purchaseInfoData = PublishSubject<[String : String]>()
    let userInfoData = PublishSubject<[String : String]>()
    
    var buttonData = PublishSubject<[ProfileButtonTableViewData]>()
    
    //MARK: - Referecenes
    let userService: UserService
    let iapService: IAPService
    
    //MARK: - Variables
    var providerType: ProviderType? = nil
    var providerTypeObservable = PublishSubject<ProviderType?>()
    
    //MARK: - Button Action Stages
    var userSigningIn = PublishSubject<Bool>()
    var userSignedIn = PublishSubject<Void>()
    
    var userSigningOut = PublishSubject<Bool>()
    var userSignedOut = PublishSubject<Void>()
    
    var userDeletingAccount = PublishSubject<Bool>()
    var userDeletedAccount = PublishSubject<Void>()
    
    var userRestoringPurchase = PublishSubject<Bool>()
    var userRestoredPurchase = PublishSubject<Void>()
    
    var errorMsg = PublishSubject<String>()
    
    //MARK: - Current Nonce
    var currentNonce: String?
    
    //MARK: - Observables
    let didCompleteWithAuthorization = PublishSubject<ASAuthorization>()
    
    init(userService: UserService, iapService: IAPService) {
        self.userService = userService
        self.iapService = iapService
        subsToDidCompleteWithAuthorization()
    }
    
    func signOut(profileController: ProfileController) {
        userSigningOut.onNext(true)
        if Auth.auth().currentUser != nil {
            userService.signOut().subscribe { [weak self] result in
                guard let self else { return }
                switch result {
                case .next():
                    userSigningOut.onNext(false)
                    userSignedOut.onNext(())
                    isUserInfoDataAvailable.onNext(false)
                    isPurchaseInfoDataAvailable.onNext(false)
                    providerTypeObservable.onNext(nil)
                case .error(let error):
                    userSigningOut.onNext(false)
                    errorMsg.onNext(error.localizedDescription)
                case .completed:
                    print("çıkış işlemi tamamlandı")
                }
                
            }.disposed(by: disposeBag)
        } else {
            userSigningOut.onNext(false)
        }
        
    }
    
    func deleteCurrentGoogleUser() {
        userDeletingAccount.onNext(true)
        if let user = Auth.auth().currentUser {
            user.delete { [weak self] error in
                guard let self else { return }
                if let error = error {
                    userDeletingAccount.onNext(false)
                    errorMsg.onNext(error.localizedDescription)
                } else {
                    isUserInfoDataAvailable.onNext(false)
                    isPurchaseInfoDataAvailable.onNext(false)
                    providerTypeObservable.onNext(nil)
                    userDeletingAccount.onNext(false)
                    userDeletedAccount.onNext(())
                }
            }
        } else {
            userDeletingAccount.onNext(false)
        }
        
        
        
    }
    
    
}

//MARK: - Apple required method for Restore
extension ProfileViewModel {
    func restorePurchases() {
        //Note that Apple does require a restore mechanism in the event a user loses access to their purchases (e.g: uninstalling/reinstalling the app, losing their account information, etc).
        userRestoringPurchase.onNext(true)
        
        iapService.restorePurchases().flatMap { isRestored in
            
            return Observable.just(isRestored)
        }.subscribe { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .next(let isRestored):
                if isRestored {
                    userRestoringPurchase.onNext(false)
                    userRestoredPurchase.onNext(())
                }
            case .error(let error):
                errorMsg.onNext(error.localizedDescription)
            case .completed:
                print("Restore işlemi tamamlandı.")
            }
        }.disposed(by: disposeBag)
        
    }
}


//MARK: - Apple Sign In / RevokeToken Methods
extension ProfileViewModel {
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
            
            Task { [weak self] in
                guard let self else { return }
                userDeletingAccount.onNext(true)
                do {
                    try await Auth.auth().revokeToken(withAuthorizationCode: authCodeString)
                    try await Auth.auth().currentUser?.delete()
                    // silindi sayfayi yenile
                    isUserInfoDataAvailable.onNext(false)
                    isPurchaseInfoDataAvailable.onNext(false)
                    providerTypeObservable.onNext(nil)
                    userDeletingAccount.onNext(false)
                    userDeletedAccount.onNext(())
                } catch {
                    userDeletingAccount.onNext(false)
                    errorMsg.onNext(error.localizedDescription)
                }
            }
        }).disposed(by: disposeBag)
    }
    
    //MARK: - Delete current apple user
    func deleteCurrentAppleUser(completion: (ASAuthorizationAppleIDRequest) -> Void) {
        userDeletingAccount.onNext(true)
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
        return Observable.create { [weak self] observer in
            guard let self else { return Disposables.create() }
            if let currentUser = Auth.auth().currentUser {
                observer.onNext(currentUser)
                setUserProviderType(currentUser: currentUser)
            } else {
                observer.onNext(nil)
                isUserInfoDataAvailable.onNext(false)
                setUserProviderType(currentUser: nil)
            }
            return Disposables.create()
        }
    }
    
    func setButtonTableViewData(makePurchaseButton: Bool? = nil) {
        checkIsCurrentUserActive().flatMap { currentUser in
            return Observable.just(currentUser)
        }.subscribe(onNext: { [weak self] currentUser in
            guard let self else { return }
            if currentUser != nil {
                let newData = [
                    ProfileButtonTableViewData.signIn(isUserSignedIn: false),
                    ProfileButtonTableViewData.restorePurchases(isUserSignedIn: makePurchaseButton ?? true),
                    ProfileButtonTableViewData.deleteAccount(isUserSignedIn: true),
                    ProfileButtonTableViewData.signOut(isUserSignedIn: true)
                ]
                buttonData.onNext(newData)
            } else {
                let newData = [
                    ProfileButtonTableViewData.signIn(isUserSignedIn: true),
                    ProfileButtonTableViewData.restorePurchases(isUserSignedIn: false),
                    ProfileButtonTableViewData.deleteAccount(isUserSignedIn: false),
                    ProfileButtonTableViewData.signOut(isUserSignedIn: false)
                ]
                buttonData.onNext(newData)
            }
        }).disposed(by: disposeBag)
        
        
    }
    
    private func setUserProviderType(currentUser: User?) {
        if let providerData = currentUser?.providerData {
            providerData.forEach { [weak self] userInfo in
                guard let self else { return }
                let providerID = userInfo.providerID
                switch providerID {
                case ProviderType.apple.rawValue:
                    providerType = .apple
                    providerTypeObservable.onNext(.apple)
                case ProviderType.google.rawValue:
                    providerType = .google
                    providerTypeObservable.onNext(.google)
                default:
                    break
                }
            }
        } else {
            providerType = nil
            providerTypeObservable.onNext(nil)
        }
    }
    
    //MARK: - Create Dictionary Data ForTableView
    private func createDictionaryDataForTableView(customerInfo: CustomerInfo) {
        var purchaseDictionaryData: [String: String] = [:]
        
        if let entitlement = customerInfo.entitlements.all[IAPConstants.entitlementIdentifier.rawValue], entitlement.isActive {
            purchaseDictionaryData["Abonelik Durumu"] = "Aktif"
            setButtonTableViewData(makePurchaseButton: false)
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
            setButtonTableViewData(makePurchaseButton: true)
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
