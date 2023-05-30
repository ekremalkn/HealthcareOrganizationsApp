//
//  SignInViewModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 20.05.2023.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import AuthenticationServices
import CryptoKit
import RxSwift
import RevenueCat


final class SignInViewModel {
    deinit {
        print("deinit SignInViewModel")
    }
    //MARK: - User Service
    private let userService: UserService

    //MARK: - DisposeBag
    private let disposeBag = DisposeBag()
    
    //MARK: - Current Nonce
    var currentNonce: String?

    //MARK: - Observables
    let didCompleteWithAuthorization = PublishSubject<ASAuthorization>()

    init(userService: UserService) {
        self.userService = userService
        subsToDidCompleteWithAuthorization()
    }
    
    
    func googleSignInWithRC(showOn parentVC: UIViewController) {
        userService.googleSignInWithRC(showOn: parentVC)
    }
    
    func signOut() {
        userService.signOut().subscribe { result in
            switch result {
            case .next():
                print("çıkış başarılı")
            case .error(let error):
                print("\(error) çıkış başarısız")
            case .completed:
                print("çıkış işlemi tamamlandı")
            }
            
        }.disposed(by: disposeBag)
    }
    
    //MARK: - Apple SignIn
    func startSignInWithAppleFlow(completion: (ASAuthorizationAppleIDRequest) -> Void) {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        completion(request)
    }
    
    
    //MARK: - When apple sign in complete with authorization
    private func subsToDidCompleteWithAuthorization() {
        didCompleteWithAuthorization.subscribe { [weak self] authorization in
            guard let self else { return }
            userService.appleSignInWithRC(authorization: authorization, currentNonce: currentNonce)
        }.disposed(by: disposeBag)
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
