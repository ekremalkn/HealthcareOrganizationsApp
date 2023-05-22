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
    
    
    func signInWithGoogle(showOn parentVC: UIViewController) {
        userService.googleSignIn(parentVC: parentVC).subscribe(onNext: { result in
            switch result {
            case .success(let successMsg):
                print(successMsg)
            case .failure(let error):
                print(error)
            }
            
        }).disposed(by: disposeBag)
    }
    
    func signOut() {
        userService.signOut().subscribe(onNext: { result in
            switch result {
            case .success(let successMsg):
                print(successMsg)
            case .failure(let error):
                print(error)
            }
            
        }).disposed(by: disposeBag)
    }
    
    
   

}
