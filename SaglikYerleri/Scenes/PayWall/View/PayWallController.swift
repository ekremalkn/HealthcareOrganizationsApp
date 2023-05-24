//
//  PayWallController.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 20.05.2023.
//

import UIKit
import RxSwift
import RevenueCat

final class PayWallController: UIViewController {

    //MARK: - References
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
    
    //MARK: - ConfigureViewController
    private func configureViewController() {
        payWallView.continueButton.rx.tap.subscribe { [weak self] _ in
            guard let self, let selectedButtonType = self.payWallView.selectedButton?.type else { return }
            viewModel.makePurchase(planType: selectedButtonType)
        }.disposed(by: disposeBag)
        
        
        payWallView.closeButton.rx.tap.subscribe { [weak self] _ in
            guard let self else { return }
            self.dismiss(animated: true)
        }.disposed(by: disposeBag)
    }


}
