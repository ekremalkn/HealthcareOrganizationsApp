//
//  SideMenuView.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 16.05.2023.
//

import UIKit

final class SideMenuView: UIView {
    deinit {
        print("SideMenuView deinitt")
    }
    //MARK: - Creating UI Elements
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        stackView.spacing = 20
        return stackView
    }()
    
    lazy var profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PROFİL", for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 13)
        button.titleLabel?.textAlignment = .left
        button.setTitleColor(.darkGray, for: .normal)
        button.setImage(UIImage(named: "profileButton"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .init(hex: "6279E0")
        return button
    }()
    
    lazy var  historyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ARAMA GEÇMİŞİ ", for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 13)
        button.titleLabel?.textAlignment = .left
        button.setTitleColor(.darkGray, for: .normal)
        button.setImage(UIImage(named: "historyButton"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .init(hex: "6279E0")
        return button
    }()
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize.init(width: 5, height: 5)
    }
    
}

extension SideMenuView: ViewProtocol {
    func configureView() {
        backgroundColor = .init(hex: "FBFCFE")
        addSubview()
        setupConstraints()
        addShadow()
    }
    
    func addSubview() {
        addSubview(buttonStackView)
        
        buttonStackView.addArrangedSubview(profileButton)
        buttonStackView.addArrangedSubview(historyButton)
    }
    
    func setupConstraints() {
        buttonStackView.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
            make.width.equalTo(self.snp.width).multipliedBy(0.80)
            make.height.equalTo(100)
        }
    }
    
    
}
