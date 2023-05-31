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
    func googleSignInWithRC(showOn: UIViewController) -> Observable<Bool>
    func appleSignInWithRC(authorization: ASAuthorization, currentNonce: String?) -> Observable<Bool>
    func signOut() -> Observable<Void>
}


final class UserNetworkService: UserService {
    
    //MARK: - DisposeBag
    private let disposeBag = DisposeBag()
    
    private func getUIDFromFirebaseGoogleSignIn(parentVC: UIViewController) -> Observable<String> {
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
    
    private func getUIDFromFirebaseAppleSignIn(authorization: ASAuthorization, currentNonce: String?) -> Observable<String> {
        return Observable.create { observer in
            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                  guard let nonce = currentNonce else {
                    fatalError("Invalid state: A login callback was received, but no login request was sent.")
                  }
                  guard let appleIDToken = appleIDCredential.identityToken else {
                    print("Unable to fetch identity token")
                      return Disposables.create()
                  }
                  guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                    print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                    return Disposables.create()
                  }
                  // Initialize a Firebase credential, including the user's full name.
                  let credential = OAuthProvider.appleCredential(withIDToken: idTokenString,
                                                                    rawNonce: nonce,
                                                                    fullName: appleIDCredential.fullName)
                
                Auth.auth().signIn(with: credential) { authResult, error in
                    if let error = error {
                        // Handle sign-in error
                        print(error.localizedDescription)
                        observer.onError(error)
                    } else {
                        guard let authResult else { return }
                        let uid = authResult.user.uid
                        observer.onNext(uid)
                        // Sign-in successful
                        print("APPLE GİRİŞ BAŞARILIR")
                        // User is signed in to Firebase with Apple.
                    }
                }
                
                }
            
            return Disposables.create()
        }
        
    }
    
    
    
    func googleSignInWithRC(showOn: UIViewController) -> Observable<Bool> {
        return Observable.create { [weak self] observer in
            guard let self else { return Disposables.create() }
            self.getUIDFromFirebaseGoogleSignIn(parentVC: showOn).flatMap { uid in
                return Observable.just(uid)
            }.subscribe { [weak self] result in
                guard let self else { return }
                switch result {
                case .next(let uid):
                    revenueCatSignIn(uid) { isSignedIn in
                        if isSignedIn {
                            observer.onNext(true)
                        } else {
                            observer.onNext(false)
                        }
                    }
                case .error(let error):
                    print("\(error) Google Sign In With RevenueCat Başarırısız !!!!")
                case .completed:
                    print("Google Sign In With RevenueCat Tamamlandı :))))")
                }
            }.disposed(by: disposeBag)
            
            return Disposables.create()
        }
            
  }
    
    func appleSignInWithRC(authorization: ASAuthorization, currentNonce: String?) -> Observable<Bool> {
        return Observable.create { [weak self] observer in
            guard let self else { return Disposables.create() }
            getUIDFromFirebaseAppleSignIn(authorization: authorization, currentNonce: currentNonce).flatMap { uid in
                return Observable.just(uid)
            }.subscribe { [weak self] result in
                guard let self else { return }
                switch result {
                case .next(let uid):
                    revenueCatSignIn(uid) { isSignedIn in
                        if isSignedIn {
                            observer.onNext(true)
                        } else {
                            observer.onNext(false)
                        }
                    }
                case .error(let error):
                    print("\(error) Apple Sign In With RevenueCat Başarırısız !!!!")
                case .completed:
                    print("Apple Sign In With RevenueCat Tamamlandı :))))")
                }
            }.disposed(by: disposeBag)
            return Disposables.create()
        }
    }
    
    private func revenueCatSignIn(_ uid: String, completion: @escaping (Bool) -> Void) {
        Purchases.shared.logIn(uid) { customerInfo, isCreated, error in
            if let error {
                completion(false)
                print(error.localizedDescription)
                return
            }
            completion(true)
            print("REVENUE CAT GİRİŞ İŞLEMİ SONUCU = \(isCreated)")
        }
    }
    
    
    // Firbase Sign Out
    func signOut() -> Observable<Void> {
        return Observable.create { observer in
            do {
                try Auth.auth().signOut()
                observer.onNext(())
                observer.onCompleted()
            } catch let signOutError as NSError {
                observer.onError(signOutError)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    
    
    
    
    deinit {
        print("deinit usernetworkservice")
    }
    
    
    
    
    
}
