//
//  SideMenuView.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 16.05.2023.
//

import UIKit

final class SideMenuView: UIView {
    
    //MARK: - Creating UI Elements
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        stackView.spacing = 20
        return stackView
    }()
    
    let profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("HESAP BILGILERI", for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 13)
        button.titleLabel?.textAlignment = .left
        button.setTitleColor(.darkGray, for: .normal)
        button.setImage(UIImage(named: "profileButton"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .blue
        return button
    }()
    
    let historyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SON ARANANLAR ", for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 13)
        button.titleLabel?.textAlignment = .left
        button.setTitleColor(.darkGray, for: .normal)
        button.setImage(UIImage(named: "historyButton"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .blue
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
        
        buttonStackView.addArrangedSubview(historyButton)
        buttonStackView.addArrangedSubview(profileButton)
    }
    
    func setupConstraints() {
        buttonStackView.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
            make.width.equalTo(self.snp.width).multipliedBy(0.80)
            make.height.equalTo(100)
        }
    }
    
    
}
