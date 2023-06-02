//
//  MainTabBarController.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 1.06.2023.
//

import UIKit
import RxSwift

//final class MainTabBarController: UITabBarController {
//
//    let mainCoordinator = MainCoordinator(navigationController: UINavigationController())
//
//    let horizontalCollectionRemoteConfigData: Observable<[MainHorizontalCollectionData]>?
//
//    //MARK: - Life Cycle Methods
//    init(horizontalCollectionRemoteConfigData: Observable<[MainHorizontalCollectionData]>?) {
//        self.horizontalCollectionRemoteConfigData = horizontalCollectionRemoteConfigData
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tabBar.clipsToBounds = true
//        tabBar.layer.cornerRadius = 12
////        tabBar.backgroundColor = .init(hex: "FBFCFE")
//        mainCoordinator.startCoordinator(horizontalCollectionData: horizontalCollectionRemoteConfigData)
//
//        viewControllers = [mainCoordinator.navigationController]
//    }
//
//
//}
