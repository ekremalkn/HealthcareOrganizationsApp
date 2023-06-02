//
//  SideMenuCoordinator.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 26.05.2023.
//

import UIKit
import SideMenu

final class SideMenuCoordinator: Coordinator {
    
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController = UINavigationController()
    
    
    func startCoordinator() {
    }
    
    func startCoordinator(from vc: MainController) {
        let sideMenuController = SideMenuController()
        
        sideMenuController.sideMenuCoordinator = self
        let sideMenuNavController = SideMenuNavigationController(rootViewController: sideMenuController)
        self.navigationController = sideMenuNavController
        SideMenuManager.default.leftMenuNavigationController = sideMenuNavController
        let navBar = navigationController.navigationBar
        SideMenuManager.default.addPanGestureToPresent(toView: navBar)
        vc.present(sideMenuNavController, animated: true)
    }
    
    func childCoordinatorDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
            
        }
    }
    
    func sideMenuClosed() {
        parentCoordinator?.childCoordinatorDidFinish(self)
    }
    
    func openRecentSearches() {
        let recentSearchesController = RecentSearchesController()
        navigationController.pushViewController(recentSearchesController, animated: true)
    }
    
    func openProfile() {
        let childCoordinator = ProfileCoordinator(navigationController: navigationController)
        childCoordinator.parentCoordinator = self
        childCoordinators.append(childCoordinator)
        childCoordinator.startCoordinator()
    }
    
    
    
}
