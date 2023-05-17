//
//  SplashView.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 17.05.2023.
//

import UIKit

final class SplashView: UIView {

    //MARK: - Creating UI Elements
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sağlık Kuruluşları"
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Black", size: 25)
        label.adjustsFontSizeToFitWidth = true
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
    }
    
    func setupConstraints() {
        loadingViewConstraints()
        titleLabelConstraints()
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
    
    
}
