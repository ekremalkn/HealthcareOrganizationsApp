//
//  GoogleSignInButton.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 20.05.2023.
//

import UIKit

enum SignInButtonType {
    case google
    case apple
}

final class CustomSignInButton: UIButton {
    
    //MARK: - Creating UI Elements
    private lazy var buttonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(type: SignInButtonType) {
        self.init(frame: .zero)
        switch type {
        case .google:
            buttonImageView.image = UIImage(named: "googleButton")
        case .apple:
            buttonImageView.image = UIImage(named: "appleButton")
        }
    }
    
    private func setupViews() {
        layer.borderColor = UIColor.init(hex: "6279E0").cgColor
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize.init(width: 3, height: 3)
        
        addSubview(buttonImageView)
        
        buttonImageView.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.height.width.equalTo(self.snp.height).multipliedBy(0.75)
        }
    }
    
    
}
