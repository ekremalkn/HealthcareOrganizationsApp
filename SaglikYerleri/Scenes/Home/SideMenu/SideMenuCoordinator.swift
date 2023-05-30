//
//  SideMenuCoordinator.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 26.05.2023.
//

import UIKit

final class SideMenuCoordinator {
    var childCoordinator: [Coordinator] = []
    
    weak var navigationController: UINavigationController?
    
    
    func startCoordinator() {
    }
    
    func openRecentSearchesController() {
        guard let navigationController else { return }
        let recentSearchesController = RecentSearchesController()
        navigationController.pushViewController(recentSearchesController, animated: true)
    }
    
    func openProifleController() {
        guard let navigationController else { return }
        let userService: UserService = UserNetworkService()
        let profileViewModel = ProfileViewModel(userService: userService)
        let profileController = ProfileController(viewModel: profileViewModel)
        navigationController.pushViewController(profileController, animated: true)
    }
    
    
    
}
