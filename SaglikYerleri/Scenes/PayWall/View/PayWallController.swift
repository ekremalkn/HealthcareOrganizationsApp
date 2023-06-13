//
//  PayWallController.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 20.05.2023.
//

import UIKit
import RxSwift
import RevenueCat
import SafariServices

final class PayWallController: UIViewController {
    deinit {
        print("deinit PayWallController")
    }
    //MARK: - References
    weak var payWallCoordinator: PayWallCoordinator?
    private let payWallView = PayWallView(selectedButton: .init(type: .annual))
    let viewModel: PayWallViewModel
    
    //MARK: - DisposeBag
    private let disposeBag = DisposeBag()
    
    //MARK: - Life Cycle Methods
    init(viewModel: PayWallViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = payWallView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        payWallCoordinator?.payWallClosed()
        
    }
    
    //MARK: - ConfigureViewController
    private func configureViewController() {
        buttonActions()
    }
    
    private func buttonActions() {
        payWallView.continueButton.rx.tap.subscribe { [weak self] _ in
            guard let self, let selectedButtonType = self.payWallView.selectedButton?.type else { return }
            viewModel.checkUserAndMakePurchase(planType: selectedButtonType)
            
        }.disposed(by: disposeBag)
        
        
        payWallView.closeButton.rx.tap.subscribe { [weak self] _ in
            guard let self else { return }
            dismiss(animated: true)
        }.disposed(by: disposeBag)
        
        
        
        payWallView.restorePurchaseButton.rx.tap.subscribe { [weak self] _ in
            guard let self else { return }
            viewModel.restorePurchase()
            
        }.disposed(by: disposeBag)
        
        payWallView.termsOfUseButton.rx.tap.subscribe {  [weak self] _ in
            guard let self else { return }
            if let url = URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/") {
                let safariViewController = SFSafariViewController(url: url)
                present(safariViewController, animated: true, completion: nil)
            }
        }.disposed(by: disposeBag)
        
        payWallView.privacyPolicyButton.rx.tap.subscribe { [weak self] _ in
            guard let self else { return }
            if let url = URL(string: "https://grotesqueryy.wixsite.com/ekremalkan/gizlilik-politikas%C4%B1") {
                let safariViewController = SFSafariViewController(url: url)
                present(safariViewController, animated: true, completion: nil)
            }
        }.disposed(by: disposeBag)
        
    }
    
}
