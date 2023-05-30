//
//  ProfileView.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 30.05.2023.
//

import UIKit

final class ProfileView: UIView {

    //MARK: - Creating UI Elements
    private lazy var userInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Kullanıcı Bilgileri"
        label.font = .systemFont(ofSize: 17)
        label.alpha = 0
        return label
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
    
    func toogleUserInfoAlpha(with status: Bool) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self else { return }
            switch status {
            case true:
                userInfoLabel.alpha = 1
                userInfoTableView.alpha = 1
            case false:
                userInfoLabel.alpha = 0
                userInfoTableView.alpha = 0
            }
        }
        
    }
    
    func tooglePurchaseInfoAlpha(with status: Bool) {
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

extension ProfileView: ViewProtocol {
    func configureView() {
        backgroundColor = .systemGray6
        addSubview()
        setupConstraints()
    }
    
    func addSubview() {
        addSubview(userInfoLabel)
        addSubview(userInfoTableView)
        addSubview(purchaseInfoLabel)
        addSubview(purchaseInfoTableView)
        addSubview(buttonTableView)
    }
    
    func setupConstraints() {
        userInfoLabelConstraints()
        userInfoTableViewConstraints()
        purchaseInfoLabelConstraints()
        purchaseInfoTableViewConstraints()
        buttonTableViewConstraints()
    }
    
    private func userInfoLabelConstraints() {
        userInfoLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(10)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(-10)
            make.height.equalTo(userInfoLabel.font.lineHeight)
        }
    }
    
    private func userInfoTableViewConstraints() {
        userInfoTableView.snp.makeConstraints { make in
            make.top.equalTo(userInfoLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(-10)
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
        
        // tableviewun en üstteki separator çizgisini kaldırmak için
        purchaseInfoTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: purchaseInfoTableView.bounds.width, height: CGFloat.leastNormalMagnitude))
    }
    
    private func buttonTableViewConstraints() {
        buttonTableView.snp.makeConstraints { make in
            make.top.equalTo(purchaseInfoTableView.snp.bottom).offset(25)
            make.leading.trailing.equalTo(userInfoTableView)
            make.height.equalTo(149)
        }
    }
    
    
}
