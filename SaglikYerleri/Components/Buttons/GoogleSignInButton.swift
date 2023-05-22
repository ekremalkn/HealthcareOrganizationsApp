//
//  GoogleSignInButton.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 20.05.2023.
//

import UIKit

final class GoogleSignInButton: UIButton {
    
    //MARK: - Creating UI Elements
    private lazy var buttonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "googleButton")
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

    private func setupViews() {
        layer.borderColor = UIColor.white.cgColor
        backgroundColor = .init(hex: "181818")
        layer.cornerRadius = 12
        
        addSubview(buttonImageView)
        
        buttonImageView.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.height.width.equalTo(self)
        }
    }
    
    
}
