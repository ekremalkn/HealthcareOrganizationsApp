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
    deinit {
        print("ProfileController  deinit")
    }
    //MARK: - References
    var profileCoordinator: ProfileCoordinator?
    private let profileView = ProfileView()
    private var viewModel: ProfileViewModel
    
    //MARK: - Dispose Bag
    private let disposeBag = DisposeBag()
    
    //MARK: - SignInVC Dismissed
    var signInVCDismissed = PublishSubject<Void>()
    
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        profileCoordinator?.profileClosed()
        
    }
    
    private func configureViewController() {
        title = "Hesap Bilgileri"
        configureNavItems()
        subscribeToDataStatus()
        buttonActionStages()
        configureTableView()
        signInVCDismissedCallback()
    }
    
    private func configureNavItems() {
        navigationController?.navigationBar.barTintColor = .init(hex: "F2F2F7")
        navigationController?.navigationBar.topItem?.backBarButtonItem = profileView.backButton
        
    }
    
    
}
//MARK: - Configure TableViews

extension ProfileController {
    
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
            cell.configureButtonTitle(with: buttonType.buttonOption.buttonTitle, interaction: buttonType.buttonOption.buttonInteraction, buttonTintColor: buttonType.buttonOption.buttonTintColor)
            
        }.disposed(by: disposeBag)
        
        // set button tableview data
        viewModel.setButtonTableViewData()
        
        // handle did select
        profileView.buttonTableView.rx.modelSelected(ProfileButtonTableViewData.self).subscribe(onNext: { [weak self] buttonType in
            guard let self else { return }
            switch buttonType {
            case .signOut:
                let profileAlertController = CustomAlertController(title: "Çıkış", message: "Çıkış yapmak istediğnizden emin misiniz?", preferredStyle: .actionSheet)
                
                profileAlertController.showAlertForProfile(on: self, button: .signOut(isUserSignedIn: true)) { [weak self] in
                    guard let self else { return }
                    viewModel.signOut(profileController: self)
                }
            case .deleteAccount:
                let profileAlertController = CustomAlertController(title: "Uyarı!", message: "Hesap silme işleminin sağlıklı gerçekleşmesi için, silmeden önce çıkış yapıp tekrar girmelisiniz", preferredStyle: .alert)
                
                profileAlertController.showAlertForProfile(on: self, button: .deleteAccount(isUserSignedIn: true)) { [weak self] in
                    guard let self else { return }
                    
                    guard let providerType = viewModel.providerType else { return }
                    switch providerType {
                    case .apple:
                        viewModel.deleteCurrentAppleUser { request in
                            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
                            authorizationController.delegate = self
                            authorizationController.presentationContextProvider = self
                            authorizationController.performRequests()
                        }
                        
                    case .google:
                        viewModel.deleteCurrentGoogleUser()
                    }
                    
                }
                
            case .restorePurchases:
                viewModel.restorePurchases()
            case .signIn:
                viewModel.userSigningIn.onNext(true)
                profileCoordinator?.openSignInController(onProfileVC: self)
            case .makePurchase:
                break
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

//MARK: - SignInVC Dismissed
extension ProfileController {
    private func signInVCDismissedCallback() {
        signInVCDismissed.subscribe { [weak self] _ in
            guard let self else { return }
            viewModel.userSigningIn.onNext(false)
            viewModel.userSignedIn.onNext(())
            
            viewModel.getUserInfo()
            viewModel.getCustomerPurchaseInfo()
            viewModel.setButtonTableViewData()
        }.disposed(by: disposeBag)
    }
}


//MARK: - Button Action Stages
extension ProfileController {
    private func buttonActionStages() {
        // signOut button stages
        
        viewModel.userSigningIn.subscribe { [weak self] value in
            guard let self else { return }
            if value {
                profileView.animateLoadingAnimationView(ing: true, ed: nil)
                print("Kullanıcı girişi başlatıldı")
            } else {
                profileView.animateLoadingAnimationView(ing: false, ed: nil)
                print("Kullanıcı girişi durdu")
            }
        }.disposed(by: disposeBag)
        
        viewModel.userSignedIn.subscribe { [weak self] _ in
            guard let self else { return }
            profileView.animateLoadingAnimationView(ing: nil, ed: ())
            print("Kullanıcı girişi başarıyla tamamlandı")
        }.disposed(by: disposeBag)
        
        viewModel.userSigningOut.subscribe { [weak self] value in
            guard let self else { return }
            if value {
                profileView.animateLoadingAnimationView(ing: true, ed: nil)
                print("Kullanıcı çıkışı başlatıldı")
            } else {
                profileView.animateLoadingAnimationView(ing: false, ed: nil)
                print("Kullanıcı çıkışı durdu")
            }
        }.disposed(by: disposeBag)
        
        viewModel.userSignedOut.subscribe { [weak self] _ in
            guard let self else { return }
            profileView.animateLoadingAnimationView(ing: nil, ed: ())
            viewModel.setButtonTableViewData()
            print("Kullanıcı çıkışı başarıyla tamamlandı profili dismiss et")
        }.disposed(by: disposeBag)
        
        // deleteAccount button stages
        viewModel.userDeletingAccount.subscribe { [weak self] value in
            guard let self else { return }
            if value {
                profileView.animateLoadingAnimationView(ing: true, ed: nil)
                print("Kullanıcı hesap silme işlemi başlatıldı")
            } else {
                profileView.animateLoadingAnimationView(ing: false, ed: nil)
                print("Kullanıcı hesap silme işlemi durdu")
            }
        }.disposed(by: disposeBag)
        
        viewModel.userDeletedAccount.subscribe { [weak self] _ in
            guard let self else { return }
            profileView.animateLoadingAnimationView(ing: nil, ed: ())
            profileView.changeProviderImage(providerType: nil)
            viewModel.setButtonTableViewData()
            print("Kullanıcı silme işlemi başarıyla tamamlandı. Profil sayfasını dismiss et")
        }.disposed(by: disposeBag)
        
        // restorePurchases button stages
        viewModel.userRestoringPurchase.subscribe { [weak self] value in
            guard let self else { return }
            if value {
                profileView.animateLoadingAnimationView(ing: true, ed: nil)
                print("Kullanıcı eski satın aldığını aramaya başladı")
            } else {
                profileView.animateLoadingAnimationView(ing: false, ed: nil)
                print("Kullanıcı eski satın aldığını arama işlemi tamamlandı.")
            }
        }.disposed(by: disposeBag)
        
        viewModel.userRestoredPurchase.subscribe { [weak self] _ in
            guard let self else { return }
            profileView.animateLoadingAnimationView(ing: nil, ed: ())
            print("Kullanıcı eski satın aldığını başarıyla buldu ")
            viewModel.getCustomerPurchaseInfo()
        }.disposed(by: disposeBag)
        
        viewModel.errorMsg.subscribe(onNext: { errorMsg in
            print(errorMsg)
        }).disposed(by: disposeBag)
    }
}


//MARK: - ViewModel callbacks
extension ProfileController {
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
        
        viewModel.providerTypeObservable.subscribe(onNext: { [weak self] providerType in
            guard let self else { return }
            profileView.changeProviderImage(providerType: providerType)
        }).disposed(by: disposeBag)
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
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        viewModel.userDeletingAccount.onNext(false)
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
    
    
}
