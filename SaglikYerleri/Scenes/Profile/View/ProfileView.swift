//
//  ProfileView.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 30.05.2023.
//

import UIKit
import Lottie

final class ProfileView: UIView {
    deinit {
        print("ProfileView  deinit")
    }
    //MARK: - Creating UI Elements
    lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "Ana Menü"
        button.tintColor = .init(hex: "6279E0")
        return button
    }()
    
    lazy var loadingAnimationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "LoadingAnimation")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        animationView.play()
        animationView.isHidden = true
        return animationView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .init(hex: "F2F2F7")
        return scrollView
    }()
    
    private lazy var userInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Kullanıcı Bilgileri"
        label.font = .systemFont(ofSize: 17)
        label.alpha = 0
        return label
    }()
    
    private lazy var providerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0
        return imageView
    }()
    
    lazy var userInfoTableView: UITableView = {
        let tableView = UITableView()
        tableView.bounces = false
        tableView.backgroundColor = .white
        tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
        tableView.isUserInteractionEnabled = false
        tableView.alpha = 0
        return tableView
    }()
    
    private lazy var purchaseInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Abonelik Bilgileri"
        label.font = .systemFont(ofSize: 17)
        label.alpha = 0
        return label
    }()
    
    lazy var purchaseInfoTableView: UITableView = {
        let tableView = UITableView()
        tableView.bounces = false
        tableView.backgroundColor = .white
        tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
        tableView.isUserInteractionEnabled = false
        tableView.alpha = 0
        return tableView
    }()
    
    lazy var buttonTableView: UITableView = {
        let tableView = UITableView()
        tableView.bounces = false
        tableView.backgroundColor = .white
        tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userInfoTableView.layer.cornerRadius = 12
        userInfoTableView.clipsToBounds = true
        
        purchaseInfoTableView.layer.cornerRadius = 12
        purchaseInfoTableView.clipsToBounds = true
        
        buttonTableView.layer.cornerRadius = 12
        buttonTableView.clipsToBounds = true
        
    }
    
    func animateLoadingAnimationView(ing: Bool? = nil, ed: Void? = nil) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            if let ing {
                switch ing {
                case true:
                    loadingAnimationView.play()
                    loadingAnimationView.isHidden = false
                case false:
                    loadingAnimationView.stop()
                    loadingAnimationView.isHidden = true
                }
            }
            
            if ed != nil {
                loadingAnimationView.stop()
                loadingAnimationView.isHidden = true
            }
        }
        
    }
    
    func toogleUserInfoAlpha(with status: Bool) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5) { [weak self] in
                guard let self else { return }
                switch status {
                case true:
                    buttonTableView.transform = .identity
                    scrollView.isScrollEnabled = true
                    userInfoLabel.alpha = 1
                    userInfoTableView.alpha = 1
                case false:
                    buttonTableView.transform = CGAffineTransform(translationX: 0, y: -purchaseInfoTableView.frame.origin.y)
                    scrollView.isScrollEnabled = false
                    userInfoLabel.alpha = 0
                    userInfoTableView.alpha = 0
                }
            }
        }
        
        
    }
    
    func changeProviderImage(providerType: ProviderType?) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            UIView.animate(withDuration: 0.5) { [weak self] in
                guard let self else { return }
                guard let providerType else {
                    providerImageView.alpha = 0
                    return
                }
                switch providerType {
                case .apple:
                    providerImageView.alpha = 1
                    providerImageView.image = .init(named: "appleButton")
                case .google:
                    providerImageView.alpha = 1
                    providerImageView.image = .init(named: "googleButton")
                }
            }
            
        }
        
    }
    
    func tooglePurchaseInfoAlpha(with status: Bool) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5) { [weak self] in
                guard let self else { return }
                switch status {
                case true:
                    purchaseInfoLabel.alpha = 1
                    purchaseInfoTableView.alpha = 1
                case false:
                    purchaseInfoLabel.alpha = 0
                    purchaseInfoTableView.alpha = 0
                }
            }
        }
        
    }
    
    
    
}

extension ProfileView: ViewProtocol {
    func configureView() {
        backgroundColor = .init(hex: "F2F2F7")
        addSubview()
        setupConstraints()
    }
    
    func addSubview() {
        addSubview(scrollView)
        scrollView.addSubview(userInfoLabel)
        scrollView.addSubview(providerImageView)
        scrollView.addSubview(userInfoTableView)
        scrollView.addSubview(loadingAnimationView)
        scrollView.addSubview(purchaseInfoLabel)
        scrollView.addSubview(purchaseInfoTableView)
        scrollView.addSubview(buttonTableView)
    }
    
    func setupConstraints() {
        scrollViewConstraints()
        userInfoLabelConstraints()
        providerImageViewConstraints()
        userInfoTableViewConstraints()
        loadingAnimationViewConstraints()
        purchaseInfoLabelConstraints()
        purchaseInfoTableViewConstraints()
        buttonTableViewConstraints()
    }
    
    private func scrollViewConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            make.trailing.equalTo(self.snp.trailing)
            make.leading.equalTo(self.snp.leading)
        }
    }
    
    private func providerImageViewConstraints() {
        providerImageView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(-15)
            make.height.width.equalTo(20)
        }
    }
    
    private func userInfoLabelConstraints() {
        userInfoLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollView.snp.leading).offset(10)
            make.top.equalTo(scrollView.snp.top).offset(10)
            make.trailing.equalTo(providerImageView.snp.leading).offset(-10)
            make.height.equalTo(userInfoLabel.font.lineHeight)
        }
    }
    
    private func loadingAnimationViewConstraints() {
        loadingAnimationView.snp.makeConstraints { make in
            make.centerX.equalTo(userInfoTableView.snp.centerX)
            make.bottom.equalTo(userInfoTableView.snp.top).offset(-10)
            make.height.width.equalTo(35)
        }
    }
    
    private func userInfoTableViewConstraints() {
        userInfoTableView.snp.makeConstraints { make in
            make.top.equalTo(userInfoLabel.snp.bottom).offset(10)
            make.width.equalTo(scrollView.snp.width).offset(-20)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.height.equalTo(99)
        }
    }
    
    private func purchaseInfoLabelConstraints() {
        purchaseInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(userInfoTableView.snp.bottom).offset(25)
            make.leading.trailing.equalTo(userInfoLabel)
            make.height.equalTo(purchaseInfoLabel.font.lineHeight)
        }
    }
    
    private func purchaseInfoTableViewConstraints() {
        purchaseInfoTableView.snp.makeConstraints { make in
            make.top.equalTo(purchaseInfoLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(userInfoTableView)
            make.height.equalTo(199)
        }
    }
    
    private func buttonTableViewConstraints() {
        buttonTableView.snp.makeConstraints { make in
            make.top.equalTo(purchaseInfoTableView.snp.bottom).offset(25)
            make.leading.trailing.equalTo(userInfoTableView)
            make.height.equalTo(198)
            make.bottom.equalTo(scrollView.snp.bottom)
        }
    }
    
    
}
