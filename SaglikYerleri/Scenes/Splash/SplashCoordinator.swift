//
//  SplashCoordinator.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 17.05.2023.
//

import UIKit
import RxSwift

final class SplashCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    
    var navigationController = UINavigationController()
    
    func startCoordinator() {
        let splashcontroller = SplashController()
        splashcontroller.splashCoordinator = self
        navigationController.pushViewController(splashcontroller, animated: false)
    }
    
    func openMainController(mainHorizontalCollectionData: Observable<[MainHorizontalCollectionData]>?, completion: @escaping () -> Void) {
        let mainViewModel = MainViewModel(mainHorizontalCollectionRemoteConfigData: mainHorizontalCollectionData)
        let mainController = MainController(viewModel: mainViewModel)
        mainController.mainCoordinator = MainCoordinator()
        mainController.mainCoordinator?.navigationController = self.navigationController
        navigationController.pushViewController(mainController, animated: true)
        completion()
    }
    
    deinit {
       print( "deinit splash")
    }
}

