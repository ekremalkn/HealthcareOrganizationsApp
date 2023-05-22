//
//  PayWallPlanButton.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 20.05.2023.
//

import UIKit

enum PayWallPlanButtonType {
    case yearly
    case monthly
}

final class PayWallPlanButton: UIButton {
    var type: PayWallPlanButtonType = .yearly
    
    //MARK: - Creating UI Elements
    private lazy var planTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "1 Yıl"
        label.font = UIFont(name: "ArialMT", size: 15)
        label.textAlignment = .left
        label.textColor = .white.withAlphaComponent(0.8)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "150₺"
        label.font = UIFont(name: "Arial-BoldMT", size: 32)
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var planOptionsLabel: UILabel = {
        let label = UILabel()
        label.text = "• 12.5₺/Ay"
        label.font = UIFont(name: "ArialMT", size: 15)
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    convenience init(type: PayWallPlanButtonType) {
        self.init(frame: .zero)
        setButtons(with: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setButtons(with type: PayWallPlanButtonType) {
        switch type {
        case .yearly:
            planTitleLabel.text = "1 Yıl"
            priceLabel.text = "150₺"
            planOptionsLabel.text = "• 12.5₺/Ay"
        case .monthly:
            planTitleLabel.text = "1 Ay"
            priceLabel.text = "20₺"
            planOptionsLabel.text = "• Aylık faturalandırılır"

        }
    }
    
    private func setupViews() {
        layer.borderColor = UIColor.white.cgColor
        backgroundColor = .init(hex: "181818")
        layer.cornerRadius = 12
        addSubview(planTitleLabel)
        addSubview(priceLabel)
        addSubview(planOptionsLabel)
        
        planTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(24)
            make.leading.equalTo(self.snp.leading).offset(15)
            make.trailing.equalTo(self.snp.trailing).offset(-15)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(planTitleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(planTitleLabel)
        }
        
        planOptionsLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(priceLabel)
        }
    }
    
    
}
