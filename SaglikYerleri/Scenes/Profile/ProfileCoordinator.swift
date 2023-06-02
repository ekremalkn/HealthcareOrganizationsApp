//
//  ProfileCoordinator.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 31.05.2023.
//

import UIKit


final class ProfileCoordinator: Coordinator {
    
    weak var parentCoordinator: SideMenuCoordinator?
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func startCoordinator() {
        let userService: UserService = UserNetworkService()
        let iapService: IAPService = IAPManager()
        let profileViewModel = ProfileViewModel(userService: userService, iapService: iapService)
        let profileController = ProfileController(viewModel: profileViewModel)
        profileController.profileCoordinator = self
        navigationController.pushViewController(profileController, animated: true)

    }
    
    func profileClosed() {
        parentCoordinator?.childCoordinatorDidFinish(self)
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
