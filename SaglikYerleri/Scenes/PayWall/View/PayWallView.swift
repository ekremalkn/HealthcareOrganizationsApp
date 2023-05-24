//
//  PayWallView.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 20.05.2023.
//

import UIKit
import RxSwift

final class PayWallView: UIView {
    
    //MARK: - Creating UI Elements
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "payWallBackgroundImage")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(systemName: "multiply"), for: .normal)
        button.tintColor = .white.withAlphaComponent(0.5)
        button.backgroundColor = .init(hex: "181818").withAlphaComponent(0.2)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial-BoldMT", size: 24)
        label.text = "Bütün sağlık kuruluşlarının adres bilgilerine sınırsızca erişin"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "ArialMT", size: 14)
        label.text = "Plan seçin"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    private lazy var borderView: UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = false
        button.setTitle("En iyi teklif", for: .normal)
        button.setTitleColor(.init(hex: "7C99F2"), for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 10)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var yearlyButton = PayWallPlanButton(type: .annual)
    private lazy var monthlyButton = PayWallPlanButton(type: .monthly)
    
    
    lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Devam et", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 22)
        button.backgroundColor = .init(hex: "7C99F2")
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        return button
    }()
    
    //MARK: - DisposeBag
    private let disposeBag = DisposeBag()
    
    //MARK: - Variables
    var selectedButton: PayWallPlanButton?
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        animateButtonSelections(newSelectedButton: yearlyButton)
        buttonActions()
        configureView()
    }
    
    convenience init(selectedButton: PayWallPlanButton) {
        self.init(frame: .zero)
        self.selectedButton = selectedButton
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyGradient()
        
        closeButton.layer.cornerRadius = 12.5
        closeButton.layer.masksToBounds = true
    }
    
    
    private func buttonActions() {
        monthlyButton.rx.tap.subscribe { [weak self] _ in
            guard let self else { return }
            animateButtonSelections(newSelectedButton: monthlyButton, oldSelectedButton: yearlyButton) { [weak self] in
                guard let self else { return }
                self.selectedButton = monthlyButton
            }
        }.disposed(by: disposeBag)
        
        yearlyButton.rx.tap.subscribe { [weak self] _ in
            guard let self else { return }
            animateButtonSelections(newSelectedButton: yearlyButton, oldSelectedButton: monthlyButton) { [weak self] in
                guard let self else { return }
                self.selectedButton = yearlyButton
            }
        }.disposed(by: disposeBag)
        
    }
    
    private func animateButtonSelections(newSelectedButton: PayWallPlanButton, oldSelectedButton: PayWallPlanButton? = nil, completion: (() -> Void)? = nil) {
        if newSelectedButton != self.selectedButton {
            // Eski seçili butonun border'ını azaltarak kaldır
            let shrinkAnimation = CABasicAnimation(keyPath: "borderWidth")
            shrinkAnimation.fromValue = 2.5
            shrinkAnimation.toValue = 0
            shrinkAnimation.duration = 0.3
            shrinkAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            oldSelectedButton?.layer.add(shrinkAnimation, forKey: "shrink")
            oldSelectedButton?.layer.borderWidth = 0
            
            // Yeni seçili butonun border'ını büyüterek ayarla
            let growAnimation = CABasicAnimation(keyPath: "borderWidth")
            growAnimation.fromValue = 0
            growAnimation.toValue = 2.5
            growAnimation.duration = 0.3
            growAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            newSelectedButton.layer.add(growAnimation, forKey: "grow")
            newSelectedButton.layer.borderWidth = 2.5
            
            completion?()
        }

    }

    private func applyGradient() {
        backgroundImageView.applyGradient(colors: [
            UIColor.black.cgColor,
            UIColor.black.withAlphaComponent(0.8).cgColor,
            UIColor.black.withAlphaComponent(0.6).cgColor,
            UIColor.black.withAlphaComponent(0.4).cgColor,
            UIColor.black.withAlphaComponent(0.2).cgColor,
        ], startPoint: .init(x: 0, y: 0.89), endPoint: .init(x: 0, y: 0))
        
        continueButton.applyGradient(colors: [UIColor.init(hex: "08E3FF").cgColor, UIColor.init(hex: "5799F7").cgColor])
    }
    
}

extension PayWallView: ViewProtocol {
    func configureView() {
        backgroundColor = .black
        addSubview()
        setupConstraints()
    }
    
    func addSubview() {
        addSubview(backgroundImageView)
        addSubview(closeButton)
        backgroundImageView.addSubview(titleLabel)
        backgroundImageView.addSubview(subTitleLabel)
        addSubview(yearlyButton)
        addSubview(borderView)
        addSubview(monthlyButton)
        addSubview(continueButton)
    }
    
    func setupConstraints() {
        backgroundImageViewConstraints()
        closeButtonConstraints()
        titleLabelConstraints()
        subTitleLabelConstraints()
        yearlyButtonConstraints()
        borderViewConstraints()
        monthlyButtonConstraints()
        continueButtonConstraints()
    }
    
    private func backgroundImageViewConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self)
            make.height.equalTo(self.snp.height).multipliedBy(0.5)
        }
    }
    
    private func closeButtonConstraints() {
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(15)
            make.trailing.equalTo(self.snp.trailing).offset(-15)
            make.width.height.equalTo(25)
        }
    }
    
    private func titleLabelConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundImageView.snp.bottom).offset(-50)
            make.leading.equalTo(backgroundImageView.snp.leading).offset(32)
            make.trailing.equalTo(backgroundImageView.snp.trailing).offset(-32)
        }
    }
    
    private func subTitleLabelConstraints() {
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.centerX.equalTo(titleLabel.snp.centerX)
            make.width.equalTo(titleLabel.snp.width).multipliedBy(0.60)
        }
    }
    
    private func yearlyButtonConstraints() {
        yearlyButton.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView.snp.bottom).offset(10)
            make.leading.equalTo(backgroundImageView.snp.leading).offset(24)
            make.height.width.equalTo(self.backgroundImageView.snp.width).multipliedBy(0.4)
        }
    }
    
    private func borderViewConstraints() {
        borderView.snp.makeConstraints { make in
            make.centerY.equalTo(yearlyButton.snp.top)
            make.centerX.equalTo(yearlyButton.snp.centerX)
            make.width.equalTo(yearlyButton.snp.width).multipliedBy(0.7)
            make.height.equalTo(28)
        }
    }
    
    private func monthlyButtonConstraints() {
        monthlyButton.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView.snp.bottom).offset(10)
            make.trailing.equalTo(backgroundImageView.snp.trailing).offset(-24)
            make.height.width.equalTo(self.backgroundImageView.snp.width).multipliedBy(0.4)
        }
        
    }
    
    private func continueButtonConstraints() {
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(yearlyButton.snp.bottom).offset(36)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(backgroundImageView.snp.width).multipliedBy(0.92)
            make.height.equalTo(66)
        }
    }
    
}
