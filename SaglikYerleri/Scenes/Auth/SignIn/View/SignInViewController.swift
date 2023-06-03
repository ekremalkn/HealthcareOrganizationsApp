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
    let disposeBag = DisposeBag()
    
    //MARK: - When Dissmissed
    let signInVCDismissed = PublishSubject<Void>()
    
    init(userService: UserService) {
        self.viewModel = SignInViewModel(userService: userService)
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
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
        buttonActions()
    }
    
    
    //MARK: - Button Actions
    private func buttonActions() {
        signInView.contiuneSignInWithProvider.rx.tap.subscribe { [weak self] _ in
            guard let self, let selectedButtonType = signInView.selectedButtonType else { return }
            switch selectedButtonType {
            case .google:
                viewModel.googleSignInWithRC(showOn: self).subscribe { [weak self] isSignedIn in
                    guard let self else { return }
                    if isSignedIn {
                        dismiss(animated: true) { [weak self] in
                            guard let self else { return }
                            signInVCDismissed.onNext(())
                        }
                    } else {
                        print("Google İLE Revenucata giriş yapılmadı")
                    }
                }.disposed(by: disposeBag)
            case .apple:
                viewModel.startSignInWithAppleFlow { request in
                    let authrozitaionController = ASAuthorizationController(authorizationRequests: [request])
                    authrozitaionController.delegate = self
                    authrozitaionController.presentationContextProvider = self
                    authrozitaionController.performRequests()
                    
                }
            }
        }.disposed(by: disposeBag)
        
        signInView.closeButton.rx.tap.subscribe { [weak self] _ in
            guard let self else { return }
            dismiss(animated: true) { [weak self] in
                guard let self else { return }
                signInVCDismissed.onNext(())
            }
            
        }.disposed(by: disposeBag)
    }
    
    
}

extension SignInViewController:ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        viewModel.appleSignInWithRC(authorization: authorization).subscribe { [weak self] isSignedIn in
            guard let self else { return }
            if isSignedIn {
                dismiss(animated: true) { [weak self] in
                    guard let self else { return }
                    signInVCDismissed.onNext(())
                }
            } else {
                print("APPLE ILE REvenucate giriş yapılamadı")
            }
        }.disposed(by: disposeBag)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print("Sign in with Apple errored: \(error)")
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
    
}
