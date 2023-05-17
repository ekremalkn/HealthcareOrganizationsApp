//
//  MainCoordinator.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 21.04.2023.
//

import UIKit
import SideMenu

final class MainCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    
    var navigationController = UINavigationController()
    
    
    func startCoordinator() {
    }
    
    func openMapController(categoryType: NetworkConstants, customTopViewBC: UIColor) {
        let mapController = MapController(categoryType: categoryType, customTopViewBC: customTopViewBC)
        mapController.mapCoordinator = MapCoordinator()
        navigationController.pushViewController(mapController, animated: true)
    }
    
    func openSideMenuController(from controller: UIViewController) {
        let sideMenuController = SideMenuController()
        let leftMenuNavController = SideMenuNavigationController(rootViewController: sideMenuController)
        SideMenuManager.default.leftMenuNavigationController = leftMenuNavController
        SideMenuManager.default.addPanGestureToPresent(toView: controller.navigationController!.navigationBar)
        controller.present(leftMenuNavController, animated: true)
    }
    
}
