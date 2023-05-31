//
//  ProfileController.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 30.05.2023.
//

import UIKit
import RxSwift
import AuthenticationServices

final class ProfileController: UIViewController {
    
    //MARK: - References
    private let profileView = ProfileView()
    private var viewModel: ProfileViewModel
    
    //MARK: - Dispose Bag
    private let disposeBag = DisposeBag()
    
    //MARK: - Life Cycle Methods
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    private func configureViewController() {
        subscribeToDataStatus()
        configureTableView()
    }
    
    private func subscribeToDataStatus() {
        viewModel.isUserInfoDataAvailable.subscribe { [weak self] isAvailable in
            guard let self else { return }
            if isAvailable {
                profileView.toogleUserInfoAlpha(with: true)
            } else {
                profileView.toogleUserInfoAlpha(with: false)
            }
        }.disposed(by: disposeBag)
        
        viewModel.isPurchaseInfoDataAvailable.subscribe { [weak self] isAvailable in
            guard let self else { return }
            if isAvailable {
                profileView.tooglePurchaseInfoAlpha(with: true)
            } else {
                profileView.tooglePurchaseInfoAlpha(with: false)
            }
        }.disposed(by: disposeBag)
    }
    
    private func configureTableView() {
        // User Info TableView - Bind data
        viewModel.userInfoData.bind(to: profileView.userInfoTableView.rx.items(cellIdentifier: ProfileCell.identifier, cellType: ProfileCell.self)) { index, userInfo, cell in
            cell.configure(with: userInfo)
        }.disposed(by: disposeBag)
        
        // fetch user data
        viewModel.getUserInfo()
        
        // set delegate for cell height
        profileView.userInfoTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        
        // Purchase Info TableView - Bind data
        viewModel.purchaseInfoData.bind(to: profileView.purchaseInfoTableView.rx.items(cellIdentifier: ProfileCell.identifier, cellType: ProfileCell.self)) { index, customerInfo, cell in
            cell.configure(with: customerInfo)
        }.disposed(by: disposeBag)
        
        // fetch purchase info data
        viewModel.getCustomerPurchaseInfo()
        
        // set delegate for cell height
        profileView.purchaseInfoTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        
        // Button TableView - Bind data
        viewModel.buttonData.bind(to: profileView.buttonTableView.rx.items(cellIdentifier: ProfileCell.identifier, cellType: ProfileCell.self)) { index, buttonType, cell in
            cell.configureButtonTitle(with: buttonType.buttonTitle)
        }.disposed(by: disposeBag)
        
        // handle did select
        profileView.buttonTableView.rx.modelSelected(ProfileButtonTableViewData.self).subscribe(onNext: { [weak self] buttonType in
            guard let self else { return }
            switch buttonType {
            case .signOut:
                viewModel.signOut(profileController: self)
            case .deleteAccount:
                viewModel.deleteCurrentAppleUser { request in
                    let authorizationController = ASAuthorizationController(authorizationRequests: [request])
                    authorizationController.delegate = self
                    authorizationController.presentationContextProvider = self
                    authorizationController.performRequests()
                }
            case .restorePurchases:
                print("restore button")
            }
        }).disposed(by: disposeBag)
        
        profileView.buttonTableView.rx.itemSelected.subscribe { [weak self] indexPath in
            guard let self else { return }
            profileView.buttonTableView.deselectRow(at: indexPath, animated: true)
        }.disposed(by: disposeBag)
        
        // set delegate for cell height
        profileView.buttonTableView.rx.setDelegate(self).disposed(by: disposeBag)
    }

    
    
}

//MARK: - Configure cell height
extension ProfileController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension ProfileController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        viewModel.didCompleteWithAuthorization.onNext(authorization)
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
    
    
}
