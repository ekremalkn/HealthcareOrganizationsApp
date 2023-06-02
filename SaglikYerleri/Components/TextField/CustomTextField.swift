//
//  CustomTextField.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 21.04.2023.
//

import UIKit
import RxSwift

final class CustomTextField: UITextField {
    
    //MARK: - Creating UI Elements
    lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.tintColor = .systemGray3
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let placeholderInsets = UIEdgeInsets(top: 0, left: 45, bottom: 0, right: 10)
    
    let tapGestureRecognizer = UITapGestureRecognizer()
    
    
   
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.masksToBounds = true
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: placeholderInsets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: placeholderInsets)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.placeholderRect(forBounds: bounds)
        return rect
    }
    
    
}

extension CustomTextField: ViewProtocol {
    func configureView() {
        placeholder = "Arama yapmak için dokun..."
        backgroundColor = .white
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.systemGray3.cgColor
        addSubview()
        setupConstraints()
    }
    
    func addSubview() {
        addGestureRecognizer(tapGestureRecognizer)
        addSubview(leftImageView)
    }
    
    func setupConstraints() {
        leftImageViewConstraints()
    }
    
    private func leftImageViewConstraints() {
        leftImageView.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(self.snp.leading).offset(15)
            make.height.width.equalTo(self.snp.height).multipliedBy(0.5)
        }
    }
    
}
