//
//  SplashController.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 17.05.2023.
//

import UIKit

final class SplashController: UIViewController {
    
    //MARK: - References
    weak var splashCoordinator: SplashCoordinator?
    private let splashView = SplashView()
    
    //MARK: - Life Cycle Methods
    override func loadView() {
        super.loadView()
        view = splashView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    private func configureViewController() {
        RemoteConfigManager.shared.fetchAndUpdateRemoteConfig(duration: 0) { [weak self] mainHorizontalCollectionData in
            guard let self else { return }
            if let mainHorizontalCollectionData {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.splashView.loadingView.animationView2?.stop()
                    self.splashCoordinator?.openMainController(mainHorizontalCollectionData: mainHorizontalCollectionData, completion: { [weak self] in
                        guard let self else { return }
                        self.removeFromParent()
                    })
                }
            } else {
                // default mainhorizontalcollectiondata ile aç gönder
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.splashView.loadingView.animationView2?.stop()
                    self.splashCoordinator?.openMainController(mainHorizontalCollectionData: nil, completion: { [weak self] in
                        guard let self else { return }
                        self.removeFromParent()
                    })
                }
            }
            
            
            
            
        }
        
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
        //            guard let self else { return }
        //            self.splashView.loadingView.animationView2?.stop()
        //            self.splashCoordinator?.openMainController(completion: { [weak self] in
        //                guard let self else { return }
        //                self.removeFromParent()
        //            })
        //        }
    }
    
}


