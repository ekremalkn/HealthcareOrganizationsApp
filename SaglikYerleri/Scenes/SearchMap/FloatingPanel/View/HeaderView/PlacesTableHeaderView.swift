//
//  PlacesTableHeaderView.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 10.05.2023.
//

import UIKit

final class PlacesTableHeaderView: UIView {
    
    //MARK: - Creating UI Elements
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Medium", size: 15)
        label.textColor = .darkGray
        label.textAlignment = .left
        return label
    }()
    
    private lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Medium", size: 13)
        label.textColor = .darkGray
        label.textAlignment = .right
        return label
    }()
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with numberOfItems: Int, cityName: String, countyName: String) {
        leftLabel.text = "\(cityName)/\(countyName)"
        rightLabel.text = "\(numberOfItems) sonuç bulundu"
    }
    
    private func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize.init(width: 3, height: 3)
    }
    
}

//MARK: - UI Elements AddSubview / SetupConstraints
extension PlacesTableHeaderView: ViewProtocol {
    func configureView() {
        backgroundColor = UIColor(hex: "FBFCFE")
        addShadow()
        addSubview()
        setupConstraints()
    }
    
    func addSubview() {
        addSubview(labelStackView)
        labelsToStackView()
    }
    
    private func labelsToStackView() {
        labelStackView.addArrangedSubview(leftLabel)
        labelStackView.addArrangedSubview(rightLabel)
    }
    
    func setupConstraints() {
        labelStackViewConstraints()
    }
    
    private func labelStackViewConstraints() {
        labelStackView.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(self.snp.leading).offset(20)
            make.trailing.equalTo(self.snp.trailing).offset(-20)
        }
    }
    
    
}
