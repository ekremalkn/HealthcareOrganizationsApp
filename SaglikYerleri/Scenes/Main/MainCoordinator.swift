//
//  MainCoordinator.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 21.04.2023.
//

import UIKit
import SideMenu
import RxSwift

final class MainCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func startCoordinator() {
    }
    
    func childCoordinatorDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
            
        }
    }
    
    func openSelection() {
        let childCoordinanor = SelectionPopUpCoordinator(navigationController: navigationController)
        childCoordinanor.parentCoordinator = self
        childCoordinators.append(childCoordinanor)
        childCoordinanor.startCoordinator()
    }
    
    func openMap(categoryType: NetworkConstants, cellType: CellType, customTopViewBC: UIColor) {
        let childCoordinator = MapCoordinator(navigationController: navigationController)
        childCoordinator.parentCoordinator = self
        childCoordinators.append(childCoordinator)
        childCoordinator.startCoordinator(categoryType: categoryType, cellType: cellType, customTopViewBC: customTopViewBC)
    }
    
    func openPayWall() {
        let childCoordinator = PayWallCoordinator(navigationController: navigationController)
        childCoordinator.parentCoordinator = self
        childCoordinators.append(childCoordinator)
        childCoordinator.startCoordinator()
    }
    
    func openSideMenu(from vc: MainController) {
        let childCoordinator = SideMenuCoordinator()
        childCoordinator.parentCoordinator = self
        childCoordinators.append(childCoordinator)
        childCoordinator.startCoordinator(from: vc)
        
    }
    
}
