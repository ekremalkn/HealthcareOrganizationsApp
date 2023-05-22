//
//  UserService.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 22.05.2023.
//

import Foundation
import GoogleSignIn
import FirebaseAuth
import RxSwift

protocol UserService {
    func googleSignIn(parentVC: UIViewController) -> Observable<Result<String, Error>>
    func signOut() -> Observable<Result<String, Error>>
}


final class UserNetworkService: UserService {
    func googleSignIn(parentVC: UIViewController) -> Observable<Result<String, Error>> {
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
                        let result = Result<String, Error>.failure(error)
                        observer.onNext(result)
                    } else {
                        let result = Result<String, Error>.success("Giriş Başarılı")
                        observer.onNext(result)
                        // Sign-in successful
                    }
                }
                
            }
            return Disposables.create()
        }
    }
    
    func signOut() -> Observable<Result<String, Error>> {
        return Observable.create { observer in
            do {
                try Auth.auth().signOut()
                let result = Result<String, Error>.success("Çıkış Başarılı")
                observer.onNext(result)
            } catch let signOutError as NSError {
                let result = Result<String, Error>.failure(signOutError)
                observer.onNext(result)
            }
            return Disposables.create()
        }
    }
    
    
    
    
    
    deinit {
        print("deinit usernetworkservice")
    }
    
    
    
    
    
}
