//
//  SideMenuCoordinator.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 26.05.2023.
//

import UIKit

final class SideMenuCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    
    var navigationController = UINavigationController()

    
    func startCoordinator() {
    }
    
    func openRecentSearchesController() {
        let recentSearchesController = RecentSearchesController()
        navigationController.pushViewController(recentSearchesController, animated: true)
    }
    
    func openProifleController() {
        let userService: UserService = UserNetworkService()
        let iapService: IAPService = IAPManager()
        let profileViewModel = ProfileViewModel(userService: userService, iapService: iapService)
        let profileController = ProfileController(viewModel: profileViewModel)
        profileController.profileCoordinator = ProfileCoordinator()
        navigationController.pushViewController(profileController, animated: true)
    }
    
    
    
}
