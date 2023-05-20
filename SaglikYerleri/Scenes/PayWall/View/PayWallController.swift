//
//  PayWallController.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 20.05.2023.
//

import UIKit
import RxSwift

final class PayWallController: UIViewController {

    //MARK: - References
    private let payWallView = PayWallView()
    
    //MARK: - DisposeBag
    private let disposeBag = DisposeBag()
    
    //MARK: - Life Cycle Methods
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
    }



}
