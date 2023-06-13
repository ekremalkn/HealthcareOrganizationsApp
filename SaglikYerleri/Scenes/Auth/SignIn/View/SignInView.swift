//
//  SignInView.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 20.05.2023.
//

import UIKit
import RxSwift

final class SignInView: UIView {
    deinit {
        print("deinit SignInView")
    }
    //MARK: - Creating UI Elements
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(systemName: "multiply"), for: .normal)
        button.tintColor = .white.withAlphaComponent(0.5)
        button.backgroundColor = .init(hex: "181818").withAlphaComponent(0.2)
        return button
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(named: "logoImage")
        return imageView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(hex: "FBFCFE")
        return view
    }()
    
    private lazy var buttonTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Giriş Yöntemi Seçiniz"
        label.font = UIFont(name: "Arial-BoldMT", size: 17)
        label.textAlignment = .center
        label.textColor = .init(hex: "6279E0")
        label.numberOfLines = 0
        return label
    }()
    
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 50
        return stackView
    }()
    
    private lazy var googleSignInButton = CustomSignInButton(type: .google)
    
    private lazy var appleSignInButton = CustomSignInButton(type: .apple)
    
    lazy var contiuneSignInWithProvider: UIButton = {
        let button = UIButton()
        button.setTitle("Devam et", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "ArialMT", size: 15)
        button.backgroundColor = .init(hex: "7C99F2")
        button.alpha = 0
        return button
    }()
    
    //MARK: - DisposeBag
    private let disposeBag = DisposeBag()
    
    //MARK: - Observables
    var isProviderSelected = PublishSubject<Bool>()
    
    //MARK: - Variables
    var selectedButtonType: SignInButtonType?
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        subscribeToProvider()
        buttonActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contiuneSignInWithProvider.layer.cornerRadius = 12
        contiuneSignInWithProvider.layer.masksToBounds = true
        
        closeButton.layer.cornerRadius = 12.5
        closeButton.layer.masksToBounds = true
        
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: -3, height: -3)
        contentView.layer.shadowOpacity = 0.3
        
        logoImageView.layer.shadowColor = UIColor.black.cgColor
        logoImageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        logoImageView.layer.shadowOpacity = 0.1
        
        
        applyGradient()
    }
    
    private func applyGradient() {
        contentView.applyGradient(colors: [
            UIColor.init(hex: "6279E0").withAlphaComponent(0.8).cgColor,
            UIColor.init(hex: "6279E0").withAlphaComponent(0.6).cgColor,
            UIColor.init(hex: "64B2F0").withAlphaComponent(0.6).cgColor,
            UIColor.init(hex: "64B2F0").withAlphaComponent(0.8).cgColor,
        ], cornerRadius: 12, startPoint: .init(x: 0, y: 0.89), endPoint: .init(x: 0, y: 0))
        
        contiuneSignInWithProvider.applyGradient(colors: [
            UIColor.init(hex: "6279E0").withAlphaComponent(0.8).cgColor,
            UIColor.init(hex: "6279E0").withAlphaComponent(0.6).cgColor,
            UIColor.init(hex: "64B2F0").withAlphaComponent(0.6).cgColor,
            UIColor.init(hex: "64B2F0").withAlphaComponent(0.8).cgColor,
        ])
    }
    
    private func buttonActions() {
        googleSignInButton.rx.tap.subscribe { [weak self] _ in
            guard let self else { return }
            self.buttonAnimationWhenSelected(buttonType: .google, completion: { [weak self] in
                guard let self else { return }
                self.isProviderSelected.onNext(true)
            })
        }.disposed(by: disposeBag)
        
        appleSignInButton.rx.tap.subscribe { [weak self] _ in
            self?.buttonAnimationWhenSelected(buttonType: .apple, completion: { [weak self] in
                self?.isProviderSelected.onNext(true)
            })
        }.disposed(by: disposeBag)
    }
    
    private func buttonAnimationWhenSelected(buttonType: SignInButtonType, completion: () -> Void) {
        
        switch buttonType {
        case .google:
            self.addBorderToNewSelectedButton(button: googleSignInButton)
            if let selectedButtonType {
                if selectedButtonType == .apple {
                    self.removeBorderFromOldSelectedButton(button: appleSignInButton)
                    self.selectedButtonType = .google
                }
            } else {
                self.selectedButtonType = .google
            }
        case .apple:
            self.addBorderToNewSelectedButton(button: appleSignInButton)
            if let selectedButtonType {
                if selectedButtonType == .google {
                    self.removeBorderFromOldSelectedButton(button: googleSignInButton)
                    self.selectedButtonType = .apple
                }
            } else {
                self.selectedButtonType = .apple
            }
        }
        
        
        completion()
    }
    
    private func addBorderToNewSelectedButton(button: CustomSignInButton) {
        // Yeni seçili butonun border'ını büyüterek ayarla
        let growAnimation = CABasicAnimation(keyPath: "borderWidth")
        growAnimation.fromValue = 0
        growAnimation.toValue = 2.5
        growAnimation.duration = 0.3
        growAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        button.layer.add(growAnimation, forKey: "grow")
        button.layer.borderWidth = 2.5
    }
    
    private func removeBorderFromOldSelectedButton(button: CustomSignInButton) {
        // Eski seçili butonun border'ını azaltarak kaldır
        let shrinkAnimation = CABasicAnimation(keyPath: "borderWidth")
        shrinkAnimation.fromValue = 2.5
        shrinkAnimation.toValue = 0
        shrinkAnimation.duration = 0.3
        shrinkAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        button.layer.add(shrinkAnimation, forKey: "shrink")
        button.layer.borderWidth = 0
    }
    
    private func subscribeToProvider() {
        isProviderSelected.subscribe { [weak self] value in
            guard let self else { return }
            if value {
                
                UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: { [weak self] in
                    guard let self else { return }
                    buttonTitleLabel.alpha = 0
                    let logoImageViewTransformY = buttonTitleLabel.frame.origin.y
                    logoImageView.transform = CGAffineTransform(translationX: 0, y: -logoImageViewTransformY)
                    buttonStackView.transform = CGAffineTransform(translationX: 0, y: -logoImageViewTransformY - 25)
                    contiuneSignInWithProvider.alpha = 1
                    contiuneSignInWithProvider.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                }, completion: nil)
            }
        }.disposed(by: disposeBag)
    }
    
    
}

extension SignInView: ViewProtocol {
    func configureView() {
        backgroundColor = .clear
        addSubview()
        setupConstraints()
    }
    
    func addSubview() {
        addSubview(contentView)
        contentView.addSubview(closeButton)
        contentView.addSubview(logoImageView)
        contentView.addSubview(buttonTitleLabel)
        contentView.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(googleSignInButton)
        buttonStackView.addArrangedSubview(appleSignInButton)
        contentView.addSubview(contiuneSignInWithProvider)
    }
    
    func setupConstraints() {
        closeButtonConstraints()
        logoImageViewConstraints()
        contentViewConstraints()
        buttonTitleLabelConstraints()
        buttonStackViewConstraints()
        contiuneWithGoogleConstraints()
    }
    
    private func contentViewConstraints() {
        contentView.snp.makeConstraints { make in
            make.height.equalTo(self.snp.height).multipliedBy(0.45)
            make.leading.trailing.bottom.equalTo(self)
        }
    }
    
    
    private func closeButtonConstraints() {
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(15)
            make.trailing.equalTo(self.snp.trailing).offset(-15)
            make.width.height.equalTo(25)
        }
    }
    
    private func buttonTitleLabelConstraints() {
        buttonTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(25)
            make.leading.trailing.equalTo(contentView)
            
        }
    }
    
    private func logoImageViewConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(50)
            make.height.width.equalTo(80)
            make.centerX.equalTo(contentView.snp.centerX)
        }
    }
    
    private func buttonStackViewConstraints() {
        buttonStackView.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.8)
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(logoImageView.snp.bottom).offset(50)
            
        }
    }
    
    private func contiuneWithGoogleConstraints() {
        contiuneSignInWithProvider.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.bottom).offset(UIScreen.main.bounds.height < 800 ? -32 : -56)
            make.centerX.equalTo(buttonStackView.snp.centerX)
            make.width.equalTo(buttonStackView.snp.width).multipliedBy(0.8)
            make.height.equalTo(42)
        }
    }
    
    
}
