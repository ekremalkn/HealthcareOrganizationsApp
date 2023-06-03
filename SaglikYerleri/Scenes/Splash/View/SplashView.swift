//
//  SplashView.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 17.05.2023.
//

import UIKit

final class SplashView: UIView {
    deinit {
        print("SplashView deinit")
    }
    //MARK: - Creating UI Elements
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sağlık Kuruluşları"
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Black", size: 25)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .init(hex: "282D3C")
        return label
    }()
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "İlk ayarlamalar yapılıyor lütfen bekleyiniz..."
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .init(hex: "282D3C")
        return label
    }()
    
    lazy var loadingView = AnimationView(animationType: .splashAnimation)
    
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}

extension SplashView: ViewProtocol {
    func configureView() {
        backgroundColor = UIColor(hex: "FBFCFE")
        addSubview()
        setupConstraints()
    }
    
    func addSubview() {
        addSubview(loadingView)
        loadingView.addSubview(titleLabel)
        loadingView.addSubview(infoLabel)
    }
    
    func setupConstraints() {
        loadingViewConstraints()
        titleLabelConstraints()
        infoLabelConstraints()
    }
    
    private func loadingViewConstraints() {
        loadingView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    private func titleLabelConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(loadingView.safeAreaLayoutGuide.snp.top).offset(50)
            make.width.equalTo(loadingView.snp.width).multipliedBy(0.9)
            make.centerX.equalTo(loadingView.snp.centerX)
        }
    }
    
    private func infoLabelConstraints() {
        infoLabel.snp.makeConstraints { make in
            guard let loadingAnimation = loadingView.animationView2 else { return }
            make.top.equalTo(loadingAnimation.snp.bottom).offset(10)
            make.centerX.equalTo(loadingAnimation.snp.centerX)
            make.width.equalTo(titleLabel.snp.width)
        }
    }
    
    
}
