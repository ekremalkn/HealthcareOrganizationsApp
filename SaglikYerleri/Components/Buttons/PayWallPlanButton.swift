//
//  PayWallPlanButton.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 20.05.2023.
//

import UIKit
import RevenueCat
import RxSwift

enum PayWallPlanButtonType {
    case annual
    case monthly
}

final class PayWallPlanButton: UIButton {
    var type: PayWallPlanButtonType?
    
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
    
    //MARK: - Dispose Bag
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    convenience init(type: PayWallPlanButtonType) {
        self.init(frame: .zero)
        setButtons(with: type)
        getPackages()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getPackages() {
        IAPManager.shared.getPackages().subscribe { [weak self] packages in
            switch packages {
            case .next(let packages):
                guard let self, let type = self.type else { return }
                
                switch type {
                case .annual:
                    packages.forEach {
                        if $0.packageType == .annual {
                            self.priceLabel.text = $0.localizedPriceString
                            var priceString = $0.localizedPriceString
                            if priceString.hasPrefix("$") {
                                priceString.removeFirst()
                            }
                            if let priceValue = Double(priceString) {
                                let monthlyPrice = priceValue / 12
                                let formattedPrice = String(monthlyPrice)
                                self.planOptionsLabel.text = formattedPrice
                            } else {
                                self.planOptionsLabel.text = ""
                            }
                        }
                        
                    }
                case .monthly:
                    packages.forEach {
                        if $0.packageType == .monthly {
                            self.priceLabel.text = $0.localizedPriceString
                        }
                     }
                }
            case .error(let error):
                print(error)
            case .completed:
                print("Paketler alındı")
            }
        }.disposed(by: disposeBag)
    }
    
    
    
    private func setButtons(with type: PayWallPlanButtonType) {
        self.type = type
        switch type {
        case .annual:
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
