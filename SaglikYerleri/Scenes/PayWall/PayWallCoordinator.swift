//
//  PayWallCoordinator.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 31.05.2023.
//

import UIKit

final class PayWallCoordinator: Coordinator {
    
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func startCoordinator() {
        let payWallViewModel = PayWallViewModel()
        let payWallVC = PayWallController(viewModel: payWallViewModel)
        payWallVC.payWallCoordinator = self
        payWallVC.modalPresentationStyle = .pageSheet
        navigationController.present(payWallVC, animated: true)
    }
    
    func startCoordinatorWithPresent(on vc: SelectionPopUpController) {
        let payWallViewModel = PayWallViewModel()
        let payWallVC = PayWallController(viewModel: payWallViewModel)
        payWallVC.payWallCoordinator = self
        payWallVC.modalPresentationStyle = .pageSheet
        vc.present(payWallVC, animated: true)
    }
    
    func payWallClosed() {
        parentCoordinator?.childCoordinatorDidFinish(self)
    }
    
    func openSignIn(onPayWallVC: PayWallController) {
        let userService: UserService = UserNetworkService()
        let signInVC = SignInViewController(userService: userService)
        onPayWallVC.present(signInVC, animated: true)
    }
    
    
}
