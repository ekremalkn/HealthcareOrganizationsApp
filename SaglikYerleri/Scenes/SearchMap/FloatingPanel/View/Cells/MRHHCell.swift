//
//  MRHHCell.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 9.05.2023.
//

import UIKit

protocol MRHHCellDataProtocol {
    var mrhhImageBackgroundColor: UIColor { get }
    var mrhhImage: UIImage { get }
    var mrhhName: String { get }
    var mrhhCityCountyName: String { get }
    var mrhhAddress: String { get }
    var mrhhPhone: String { get }
    var mrhhEmail: String { get }
}

final class MRHHCell: UITableViewCell {
    static let identifier = "MRHHCell"
    
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
    
    private lazy var cityCountyLabel: UILabel = {
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
        label.textAlignment = .left
        return label
    }()
    
    private lazy var phoneMailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    //MARK: - Init Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        leftImageBackgroundView.layer.cornerRadius = (contentView.frame.height * 0.5) / 2
    }
    
    func configure(with data: MRHHCellDataProtocol) {
        leftImageBackgroundView.backgroundColor = data.mrhhImageBackgroundColor.withAlphaComponent(0.2)
        leftImageView.image = data.mrhhImage
        cityCountyLabel.text = data.mrhhCityCountyName
        nameLabel.text = data.mrhhName
        phoneLabel.text = data.mrhhPhone
        emailLabel.text = data.mrhhEmail
    }
    
    
}

//MARK: - UI Element AddSubview / SetupConstraints
extension MRHHCell: CellProtocol {
    func configureCell() {
        addSubview()
        setupConstraints()
    }
    
    func addSubview() {
        contentView.addSubview(leftImageBackgroundView)
        leftImageBackgroundView.addSubview(leftImageView)
        contentView.addSubview(cityCountyLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(phoneMailStackView)
        phoneMailLabelToStackView()
    }
    
    private func phoneMailLabelToStackView() {
        phoneMailStackView.addArrangedSubview(phoneLabel)
        phoneMailStackView.addArrangedSubview(emailLabel)
    }
    
    func setupConstraints() {
        leftImageBackgroundViewConstraints()
        leftImageViewConstraints()
        cityCountyLabelConstraints()
        nameLabelConstraints()
        addressLabelConstraints()
        phoneMailStackViewConstraints()
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
    
    private func cityCountyLabelConstraints() {
        cityCountyLabel.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
            make.top.equalTo(contentView.snp.top).offset(10)
            make.height.equalTo(cityCountyLabel.font.lineHeight)
            
        }
    }
    
    private func nameLabelConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(leftImageBackgroundView.snp.top)
            make.height.equalTo(nameLabel.font.lineHeight)
            make.leading.equalTo(leftImageBackgroundView.snp.trailing).offset(10)
            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
        }
    }
    
    private func addressLabelConstraints() {
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.height.equalTo(addressLabel.font.lineHeight)
            make.leading.trailing.equalTo(nameLabel)
        }
    }
    
    private func phoneMailStackViewConstraints() {
        phoneMailStackView.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(10)
            make.height.equalTo(phoneLabel.font.lineHeight)
            make.leading.trailing.equalTo(addressLabel)
            
        }
    }
}
