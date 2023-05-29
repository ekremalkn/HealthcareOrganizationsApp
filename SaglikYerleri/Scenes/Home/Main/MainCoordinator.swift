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
    
    func openMapController(categoryType: NetworkConstants, cellType: CellType, customTopViewBC: UIColor) {
//                let userService: UserService = UserNetworkService()
//                let signinvc = SignInViewController(userService: userService)
//                navigationController.pushViewController(signinvc, animated: true)
//        let payWallViewModel = PayWallViewModel()
//        let payWallVC = PayWallController(viewModel: payWallViewModel)
//        payWallVC.modalPresentationStyle = .pageSheet
//        navigationController.present(payWallVC, animated: true)
                let networkService: CityCountyService = NetworkService()
        let mapController = MapController(categoryType: categoryType, cellType: cellType, networkService: networkService, customTopViewBC: customTopViewBC)
                mapController.mapCoordinator = MapCoordinator()
                navigationController.pushViewController(mapController, animated: true)
    }
    
    func openSideMenuController(from controller: MainController) {
        let sideMenuController = SideMenuController()
        
        let sideMenuCoordinator = SideMenuCoordinator()
        sideMenuController.sideMenuCoordinator = sideMenuCoordinator
        
        let sideMenuNavController = SideMenuNavigationController(rootViewController: sideMenuController)
        sideMenuCoordinator.navigationController = sideMenuNavController
        
        SideMenuManager.default.leftMenuNavigationController = sideMenuNavController
        guard let navBar = controller.navigationController?.navigationBar else { return }
        SideMenuManager.default.addPanGestureToPresent(toView: navBar)
        
        controller.present(sideMenuNavController, animated: true)
    }
    
}
