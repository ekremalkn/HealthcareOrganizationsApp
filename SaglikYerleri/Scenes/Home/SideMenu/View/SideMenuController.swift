//
//  SideMenuController.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 16.05.2023.
//

import UIKit
import RxSwift

final class SideMenuController: UIViewController {
    
    //MARK: - References
    var sideMenuCoordinator: SideMenuCoordinator?
    private let sideMenuView = SideMenuView()
    
    //MARK: - DisposeBag
    private let disposeBag = DisposeBag()

    //MARK: - Life Cycle Methods
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    private func configureViewController() {
        setupView()
        recentSearchesButtonAction()
    }
  
    
    //MARK: - Button Actions subsc
    private func recentSearchesButtonAction() {
        sideMenuView.historyButton.rx.tap.subscribe { [weak self] _ in
            guard let self else { return }
            self.sideMenuCoordinator?.openRecentSearchesController()
        }.disposed(by: disposeBag)
        
        sideMenuView.profileButton.rx.tap.subscribe { [weak self] _ in
            guard let self else { return }
            
        }.disposed(by: disposeBag)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(sideMenuView)
        
        sideMenuView.snp.makeConstraints { make in
            make.top.leading.bottom.equalTo(self.view)
            make.trailing.equalTo(self.view.snp.trailing).offset(-5)
        }
    }
}
