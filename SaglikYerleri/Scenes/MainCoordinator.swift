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
        navigationController.pushViewController(mainControler, animated: false)
    }
    
    
}
