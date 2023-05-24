//
//  SignInViewController.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 20.05.2023.
//

import UIKit
import RxSwift

final class SignInViewController: UIViewController {
    deinit {
        print("deinit sign in viewc")
    }
    //MARK: - References
    private let signInView = SignInView()
    private let viewModel: SignInViewModel
    
    //MARK: - DisposeBag
    private let disposeBag = DisposeBag()
    
    init(userService: UserService) {
        self.viewModel = SignInViewModel(userService: userService)
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle Methods
    override func loadView() {
        super.loadView()
        view = signInView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInView.contiuneWithGoogle.rx.tap.subscribe { [weak self] _ in
            guard let self else { return }
            self.viewModel.signInWithGoogle(showOn: self)
        }.disposed(by: disposeBag)
    }
    
 
}
