//
//  SignInViewModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 20.05.2023.
//

import Foundation
import Firebase
import GoogleSignIn
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
    
    init(userService: UserService) {
        self.userService = userService
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
    
    
   

}
