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
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "signInBackgroundImage")
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        return imageView
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
    
    private lazy var andLabel: UILabel = {
        let label = UILabel()
        label.text = "ya da"
        label.font = UIFont(name: "ArialMT", size: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .clear
        return label
    }()
    
    private lazy var withOutSignInButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle("Giriş yapmadan devam et", for: .normal)
        button.titleLabel?.font = UIFont(name: "ArialMT", size: 22)
        button.tintColor = .white
        return button
    }()
    
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
        applyGradient()
    }
    
    private func applyGradient() {
        backgroundImageView.applyGradient(colors: [
            UIColor.black.cgColor,
            UIColor.black.withAlphaComponent(0.8).cgColor,
            UIColor.black.withAlphaComponent(0.6).cgColor,
            UIColor.black.withAlphaComponent(0.4).cgColor,
            UIColor.black.withAlphaComponent(0.2).cgColor,
        ], startPoint: .init(x: 0, y: 0.89), endPoint: .init(x: 0, y: 0))
        
        contiuneSignInWithProvider.applyGradient(colors: [UIColor.init(hex: "0F4606").cgColor, UIColor.init(hex: "101110").cgColor])
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
                    self.contiuneSignInWithProvider.alpha = 1
                    self.contiuneSignInWithProvider.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                }, completion: nil)
            }
        }.disposed(by: disposeBag)
    }
    
    
}

extension SignInView: ViewProtocol {
    func configureView() {
        backgroundColor = .black
        addSubview()
        setupConstraints()
    }
    
    func addSubview() {
        addSubview(backgroundImageView)
        addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(googleSignInButton)
        buttonStackView.addArrangedSubview(appleSignInButton)
        addSubview(andLabel)
        addSubview(withOutSignInButton)
        addSubview(contiuneSignInWithProvider)
    }
    
    func setupConstraints() {
        backgroundImageViewConstraints()
        buttonStackViewConstraints()
        andLabelConstraints()
        withOutSignInButtonConstraints()
        contiuneWithGoogleConstraints()
    }
    
    private func backgroundImageViewConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self)
            make.height.equalTo(self.snp.height).multipliedBy(0.6)
        }
    }
    
    private func buttonStackViewConstraints() {
        buttonStackView.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundImageView.snp.bottom)
            make.height.equalTo(100)
            make.leading.equalTo(backgroundImageView.snp.leading).offset(40)
            make.trailing.equalTo(backgroundImageView.snp.trailing).offset(-40)
        }
    }
    
    private func andLabelConstraints() {
        andLabel.snp.makeConstraints { make in
            make.top.equalTo(buttonStackView.snp.bottom).offset(15)
            make.height.equalTo(18)
            make.centerX.equalTo(buttonStackView.snp.centerX)
            make.width.equalTo(backgroundImageView.snp.width).multipliedBy(0.75)
        }
    }
    
    private func withOutSignInButtonConstraints() {
        withOutSignInButton.snp.makeConstraints { make in
            make.top.equalTo(andLabel.snp.bottom).offset(30)
            make.height.equalTo(22)
            make.centerX.equalTo(andLabel.snp.centerX)
            make.width.equalTo(self.snp.width).multipliedBy(0.75)
        }
    }
    
    private func contiuneWithGoogleConstraints() {
        contiuneSignInWithProvider.snp.makeConstraints { make in
            make.top.equalTo(withOutSignInButton.snp.bottom).offset(30)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(self.snp.width).multipliedBy(0.55)
            make.height.equalTo(55)
        }
    }
    
    
}
