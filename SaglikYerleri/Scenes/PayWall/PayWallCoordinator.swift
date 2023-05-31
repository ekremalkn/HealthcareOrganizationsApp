//
//  PayWallCoordinator.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 31.05.2023.
//

import UIKit

final class PayWallCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    
    var navigationController =  UINavigationController()
    
    func startCoordinator() {
        
    }
    
    func openSignInController(onPayWallVC: PayWallController) {
        let userService: UserService = UserNetworkService()
        let signInVC = SignInViewController(userService: userService)
        signInVC.modalPresentationStyle = .pageSheet
        onPayWallVC.present(signInVC, animated: true)
    }
    
    
}
