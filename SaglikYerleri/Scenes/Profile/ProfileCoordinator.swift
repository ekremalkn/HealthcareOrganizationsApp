//
//  ProfileCoordinator.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 31.05.2023.
//

import UIKit


final class ProfileCoordinator: Coordinator {
    deinit {
        print("profile coordinator deinit")
    }
    var childCoordinator: [Coordinator] = []
    
    var navigationController = UINavigationController()
    
    func startCoordinator() {
    }
    
    func openSignInController(onProfileVC: ProfileController) {
        let userService: UserService = UserNetworkService()
        let signinvc = SignInViewController(userService: userService)
        
        signinvc.signInVCDismissed.subscribe { _ in
            onProfileVC.signInVCDismissed.onNext(())
        }.disposed(by: signinvc.disposeBag)
        
        onProfileVC.present(signinvc, animated: true)
    }
    
    
}
