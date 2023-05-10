//
//  PharmacyCell.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 8.05.2023.
//

import UIKit

protocol PharmacyCellDataProtocol {
    var pharmacyImageBackgroundColor: UIColor { get }
    var pharmacyImage: UIImage { get }
    var pharmacyName: String { get }
    var pharmacyCityCountyName: String { get }
    var pharmacyDistrictName: String { get }
    var pharmacyAddress: String { get }
    var pharmacyPhone1: String { get }
    var pharmacyPhone2: String { get }
    var pharmacyDirections: String { get}
}

final class PharmacyCell: UITableViewCell {
    static let identifier = "PharmacyCell"
    
    //MARK: - Creating UI Elements
    private lazy var leftImageBackgroundView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var cityStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 2
        return stackView
    }()
    
    private lazy var cityCountyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 1
        label.textColor = .gray
        label.textAlignment = .right
        return label
    }()
    
    private lazy var districtLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 1
        label.textColor = .gray
        label.textAlignment = .right
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 2
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 3
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var phoneStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var phoneNumber1Label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private lazy var phoneNumber2Label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private lazy var directionsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 3
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        makeCornerRadius()
    }
    
    func configure(with data: PharmacyCellDataProtocol) {
        leftImageBackgroundView.backgroundColor = data.pharmacyImageBackgroundColor.withAlphaComponent(0.2)
        leftImageView.image = data.pharmacyImage
        nameLabel.text = data.pharmacyName
        addressLabel.text = data.pharmacyAddress
        cityCountyLabel.text = data.pharmacyCityCountyName
        districtLabel.text = data.pharmacyDistrictName
        phoneNumber1Label.text = data.pharmacyPhone1
        phoneNumber2Label.text = data.pharmacyPhone2
        directionsLabel.text = data.pharmacyDirections
    }
    
    private func addShadow() {
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize.init(width: 3, height: 5)
    }
    
    private func makeCornerRadius() {
        leftImageBackgroundView.layer.cornerRadius = (contentView.frame.height * 0.5) / 2
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10))
        contentView.layer.cornerRadius = 12
    }
    
    
}

//MARK: - UI Element AddSubview / SetupConstraints
extension PharmacyCell: CellProtocol {
    func configureCell() {
        backgroundColor = .white
        contentView.backgroundColor = UIColor(hex: "FBFCFE")
        addShadow()
        addSubview()
        setupConstraints()
    }
    
    func addSubview() {
        contentView.addSubview(leftImageBackgroundView)
        leftImageBackgroundView.addSubview(leftImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(cityStackView)
        contentView.addSubview(addressLabel)
        cityCountyDistrictLabelToStackView()
        contentView.addSubview(phoneStackView)
        phoneNumberToStackView()
        contentView.addSubview(directionsLabel)
    }
    
    private func cityCountyDistrictLabelToStackView() {
        cityStackView.addArrangedSubview(cityCountyLabel)
        cityStackView.addArrangedSubview(districtLabel)
    }
    
    private func phoneNumberToStackView() {
        phoneStackView.addArrangedSubview(phoneNumber1Label)
        phoneStackView.addArrangedSubview(phoneNumber2Label)
    }
    
    func setupConstraints() {
        leftImageBackgroundViewConstraints()
        leftImageViewConstraints()
        cityStackViewConstraints()
        nameLabelConstraints()
        addressLabelConstraints()
        phoneStackViewConstraints()
        directionsLabelConstraints()
    }
    
    private func leftImageBackgroundViewConstraints() {
        leftImageBackgroundView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.centerY.equalTo(contentView.snp.centerY)
            make.height.width.equalTo(contentView.snp.height).multipliedBy(0.5)
        }
    }
    
    private func leftImageViewConstraints() {
        leftImageView.snp.makeConstraints { make in
            make.center.equalTo(leftImageBackgroundView.snp.center)
            make.height.width.equalTo(leftImageBackgroundView.snp.height).multipliedBy(0.6)
        }
    }
    
    private func cityStackViewConstraints() {
        cityStackView.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
            make.top.equalTo(contentView.snp.top).offset(10)
            make.height.equalTo(leftImageBackgroundView.snp.height).multipliedBy(0.5)
            
        }
    }
    
    private func nameLabelConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(leftImageBackgroundView.snp.top)
            make.height.equalTo(nameLabel.font.lineHeight)
            make.leading.equalTo(leftImageBackgroundView.snp.trailing).offset(10)
            make.trailing.equalTo(cityStackView.snp.leading).offset(-10)
        }
    }
    
    private func addressLabelConstraints() {
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.height.equalTo(addressLabel.font.lineHeight)
            make.leading.equalTo(nameLabel.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
        }
    }
    
    private func phoneStackViewConstraints() {
        phoneStackView.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(10)
            make.height.equalTo(addressLabel.font.lineHeight)
            make.leading.trailing.equalTo(addressLabel)
            
        }
    }
    
    private func directionsLabelConstraints() {
        directionsLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneStackView.snp.bottom).offset(10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
            make.leading.trailing.equalTo(addressLabel)
        }
    }
    
    
}
