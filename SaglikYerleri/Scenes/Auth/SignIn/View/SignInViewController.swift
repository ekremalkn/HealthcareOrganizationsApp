//
//  SignInViewController.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 20.05.2023.
//

import UIKit
import RxSwift
import AuthenticationServices

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
        signInView.contiuneSignInWithProvider.rx.tap.subscribe { [weak self] _ in
            guard let self, let selectedButtonType = signInView.selectedButtonType else { return }
            switch selectedButtonType {
            case .google:
//                viewModel.googleSignInWithRC(showOn: self)
                            self.viewModel.signOut()
            case .apple:
                viewModel.startSignInWithAppleFlow { request in
                    let authrozitaionController = ASAuthorizationController(authorizationRequests: [request])
                    authrozitaionController.delegate = self
                    authrozitaionController.presentationContextProvider = self
                    authrozitaionController.performRequests()
                    
                }
            }
        }.disposed(by: disposeBag)
    }
    
 
}

extension SignInViewController:ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        viewModel.didCompleteWithAuthorization.onNext(authorization)
      }

      func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print("Sign in with Apple errored: \(error)")
      }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
    
}
