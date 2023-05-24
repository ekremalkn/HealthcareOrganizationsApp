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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self else { return }
            self.splashView.loadingView.animationView2?.stop()
            self.splashCoordinator?.openMainController(completion: { [weak self] in
                guard let self else { return }
                self.removeFromParent()
            })
        }
    }

}


