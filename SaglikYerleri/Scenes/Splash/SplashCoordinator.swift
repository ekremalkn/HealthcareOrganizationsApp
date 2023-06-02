//
//  SplashCoordinator.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 17.05.2023.
//

import UIKit
import RxSwift

final class SplashCoordinator: Coordinator {
    deinit {
        print("SplashCoordinator deinit")
    }
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController = UINavigationController()
    
    func startCoordinator() {
        let splashcontroller = SplashController()
        splashcontroller.splashCoordinator = self
        navigationController.pushViewController(splashcontroller, animated: false)
    }
    
    func openMain(mainHorizontalCollectionData: Observable<[MainHorizontalCollectionData]>?, completion: @escaping () -> Void) {
        let mainViewModel = MainViewModel(mainHorizontalCollectionRemoteConfigData: mainHorizontalCollectionData)
        let mainController = MainController(viewModel: mainViewModel)
        mainController.mainCoordinator = MainCoordinator(navigationController: navigationController)
        navigationController.pushViewController(mainController, animated: true)
        completion()
    }
    
}

