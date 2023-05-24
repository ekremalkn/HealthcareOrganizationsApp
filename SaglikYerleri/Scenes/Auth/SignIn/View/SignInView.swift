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
    
    private lazy var googleSignInButton = GoogleSignInButton()
    
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
    
    lazy var contiuneWithGoogle: UIButton = {
        let button = UIButton()
        button.setTitle("Google ile devam et", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "ArialMT", size: 15)
        button.backgroundColor = .init(hex: "7C99F2")
        button.alpha = 0
        return button
    }()
    
    //MARK: - DisposeBag
    private let disposeBag = DisposeBag()
    
    var isProviderSelected = PublishSubject<Bool>()
    
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
        contiuneWithGoogle.layer.cornerRadius = 12
        contiuneWithGoogle.layer.masksToBounds = true
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
        
        contiuneWithGoogle.applyGradient(colors: [UIColor.init(hex: "0F4606").cgColor, UIColor.init(hex: "101110").cgColor])
    }
    
    private func buttonActions() {
        googleSignInButton.rx.tap.subscribe { [weak self] _ in
            guard let self else { return }
            self.buttonAnimationWhenSelected { [weak self] in
                guard let self else { return }
                self.isProviderSelected.onNext(true)
            }
        }.disposed(by: disposeBag)
    }
    
    private func buttonAnimationWhenSelected(completion: () -> Void) {
        // Yeni seçili butonun border'ını büyüterek ayarla
        let growAnimation = CABasicAnimation(keyPath: "borderWidth")
        growAnimation.fromValue = 0
        growAnimation.toValue = 2.5
        growAnimation.duration = 0.3
        growAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        self.googleSignInButton.layer.add(growAnimation, forKey: "grow")
        self.googleSignInButton.layer.borderWidth = 2.5
        completion()
    }
    
    private func subscribeToProvider() {
        isProviderSelected.subscribe { [weak self] value in
            guard let self else { return }
            if value {
                UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: { [weak self] in
                    guard let self else { return }
                    self.contiuneWithGoogle.alpha = 1
                    self.contiuneWithGoogle.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
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
        addSubview(googleSignInButton)
        addSubview(andLabel)
        addSubview(withOutSignInButton)
        addSubview(contiuneWithGoogle)
    }
    
    func setupConstraints() {
        backgroundImageViewConstraints()
        googleSignInButtonConstraints()
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
    
    private func googleSignInButtonConstraints() {
        googleSignInButton.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundImageView.snp.bottom)
            make.height.width.equalTo(100)
            make.centerX.equalTo(backgroundImageView.snp.centerX)
        }
    }
    
    private func andLabelConstraints() {
        andLabel.snp.makeConstraints { make in
            make.top.equalTo(googleSignInButton.snp.bottom).offset(15)
            make.height.equalTo(18)
            make.centerX.equalTo(googleSignInButton.snp.centerX)
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
        contiuneWithGoogle.snp.makeConstraints { make in
            make.top.equalTo(withOutSignInButton.snp.bottom).offset(30)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(self.snp.width).multipliedBy(0.55)
            make.height.equalTo(55)
        }
    }
    
    
}
