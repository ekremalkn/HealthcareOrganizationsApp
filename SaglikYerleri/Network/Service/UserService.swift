//
//  UserService.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 22.05.2023.
//

import Foundation
import GoogleSignIn
import AuthenticationServices
import FirebaseAuth
import RxSwift
import RevenueCat

protocol UserService {
    func googleSignInWithRC(showOn: UIViewController)
    func appleSignInWithRC(authorization: ASAuthorization, currentNonce: String?)
    func signOut() -> Observable<Void>
}


final class UserNetworkService: UserService {
    
    //MARK: - DisposeBag
    private let disposeBag = DisposeBag()
    
    private func getGoogleUserUID(parentVC: UIViewController) -> Observable<String> {
        return Observable.create { observer in
            GIDSignIn.sharedInstance.signIn(withPresenting: parentVC) { result, error in
                guard error == nil else {
                    // Sign In Hatalı
                    return
                }
                
                guard let user = result?.user, let idToken = user.idToken?.tokenString else {
                    // user id token erişilemedi
                    return
                }
                
                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
                
                Auth.auth().signIn(with: credential) { authResult, error in
                    if let error = error {
                        // Handle sign-in error
                        observer.onError(error)
                    } else {
                        guard let authResult else { return }
                        let uid = authResult.user.uid
                        observer.onNext(uid)
                        // Sign-in successful
                    }
                }
                
            }
            return Disposables.create()
        }
    }
    
    func appleSignInWithRC(authorization: ASAuthorization, currentNonce: String?) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
              guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
              }
              guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
              }
              guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
              }
              // Initialize a Firebase credential, including the user's full name.
              let credential = OAuthProvider.appleCredential(withIDToken: idTokenString,
                                                                rawNonce: nonce,
                                                                fullName: appleIDCredential.fullName)
              // Sign in with Firebase.
              Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error {
                  // Error. If error.code == .MissingOrInvalidNonce, make sure
                  // you're sending the SHA256-hashed nonce as a hex string with
                  // your request to Apple.
                  print(error.localizedDescription)
                  return
                } else {
                    print("APPLE GİRİŞ BAŞARILIR")
                    // User is signed in to Firebase with Apple.
                    // ...
                }
                
              }
            }
    }
    
    
    
    func googleSignInWithRC(showOn: UIViewController) {
            self.getGoogleUserUID(parentVC: showOn).flatMap { uid in
                return Observable.just(uid)
            }.subscribe { [weak self] result in
                guard let self else { return }
                switch result {
                case .next(let uid):
                    self.revenueCatSignIn(uid)
                case .error(let error):
                    print("\(error) Google Sign In With RevenueCat Başarırısız !!!!")
                case .completed:
                    print("Google Sign In With RevenueCat Başarılı :))))")
                }
            }.disposed(by: self.disposeBag)
  }
    
    private func revenueCatSignIn(_ uid: String) {
        Purchases.shared.logIn(uid) { customerInfo, isCreated, error in
            if let error {
                print(error.localizedDescription)
                return
            }
            print("REVENUE CAT GİRİŞ İŞLEMİ SONUCU = \(isCreated)")
        }
    }
    
    
    // Firbase Sign Out
    func signOut() -> Observable<Void> {
        return Observable.create { observer in
            do {
                try Auth.auth().signOut()
                observer.onNext(())
            } catch let signOutError as NSError {
                observer.onError(signOutError)
            }
            return Disposables.create()
        }
    }
    
    
    
    
    
    deinit {
        print("deinit usernetworkservice")
    }
    
    
    
    
    
}
