//
//  SplashController.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 17.05.2023.
//

import UIKit
import RxSwift

final class SplashController: UIViewController {
    deinit {
        print("Splash controller deinit")
    }
    //MARK: - References
    weak var splashCoordinator: SplashCoordinator?
    private let splashView = SplashView()
    private let viewModel = SplashViewModel()
    
    //MARK: - Dispose Bag
    private let disposeBag = DisposeBag()
    
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
        viewModel.setAndCheckIsFirstLaunch { isFirstLaunch in
            if isFirstLaunch {
                firstLaunch()
            } else {
                isNotFirstLauch()
            }
        }
    }
    
    private func firstLaunch() {
        viewModel.fetchAndUpdateRemoteConfig { [weak self] mainHorizontalCollectionData in
            guard let self else { return }
            if let mainHorizontalCollectionData {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                    guard let self else { return }
                    splashView.loadingView.animationView2?.stop()
                    splashCoordinator?.openMain(mainHorizontalCollectionData: mainHorizontalCollectionData, completion: { [weak self] in
                        guard let self else { return }
                        self.removeFromParent()
                    })
                }
            } else {
                // default mainhorizontalcollectiondata ile aç gönder
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                    guard let self else { return }
                    splashView.loadingView.animationView2?.stop()
                    splashCoordinator?.openMain(mainHorizontalCollectionData: nil, completion: { [weak self] in
                        guard let self else { return }
                        self.removeFromParent()
                    })
                }
            }
            
        }
    }
    
    private func isNotFirstLauch() {
        splashView.loadingView.animationView2?.removeFromSuperview()
        splashView.infoLabel.removeFromSuperview()
        
        viewModel.fetchAndUpdateRemoteConfig { [weak self] mainHorizontalCollectionData in
            guard let self else { return }
            if let mainHorizontalCollectionData {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                    guard let self else { return }
                    splashCoordinator?.openMain(mainHorizontalCollectionData: mainHorizontalCollectionData, completion: { [weak self] in
                        guard let self else { return }
                        self.removeFromParent()
                    })
                }
            } else {
                // default mainhorizontalcollectiondata ile aç gönder
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                    guard let self else { return }
                    splashCoordinator?.openMain(mainHorizontalCollectionData: nil, completion: { [weak self] in
                        guard let self else { return }
                        self.removeFromParent()
                    })
                }
            }
            
        }
    }
    
    
    
}


