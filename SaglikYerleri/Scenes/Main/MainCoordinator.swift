//
//  MainCoordinator.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 21.04.2023.
//

import UIKit

final class MainCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    
    var navigationController = UINavigationController()
    
    func startCoordinator() {
        let mainControler = MainController()
        mainControler.mainCoordinator = self
        navigationController.pushViewController(mainControler, animated: false)
    }
    
    func openMapController(categoryType: NetworkConstants) {
        let mapController = MapController()
        let mapViewModel = MapViewModel(type: categoryType)
        mapController.mapViewModel = mapViewModel
        navigationController.pushViewController(mapController, animated: true)
    }
    
}
