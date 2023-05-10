//
//  SharedCell2.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 10.05.2023.
//

import UIKit

protocol SharedCell2DataProtocol where Self: Codable {
    var sharedCell2ImageBackgroundColor: UIColor { get }
    var sharedCell2Image: UIImage { get }
    var sharedCell2Name: String { get }
    var sharedCell2CityCountyName: String { get }
    var sharedCell2Street: String { get }
    var sharedCell2Phone: String { get }
    var sharedCell2Fax: String { get }
    var sharedCell2WebSite: String { get }
}

final class SharedCell2: UITableViewCell {
    static let identifier = "SharedCell2"
    
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
    
    private lazy var streetLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 3
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 7
        return stackView
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var faxLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var webSiteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
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
        makeCornerRadius()
    }
    
    func configure(with data: SharedCell2DataProtocol) {
        leftImageBackgroundView.backgroundColor = data.sharedCell2ImageBackgroundColor.withAlphaComponent(0.2)
        leftImageView.tintColor = data.sharedCell2ImageBackgroundColor
        leftImageView.image = data.sharedCell2Image
        cityCountyLabel.text = data.sharedCell2CityCountyName
        nameLabel.text = data.sharedCell2Name
        streetLabel.text = data.sharedCell2Street
        phoneLabel.text = data.sharedCell2Phone
        faxLabel.text = data.sharedCell2Fax
        webSiteLabel.text = data.sharedCell2WebSite
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

//MARK: - UI Elements AddSubview / SetupConstraints
extension SharedCell2: CellProtocol {
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
        contentView.addSubview(cityCountyLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(streetLabel)
        contentView.addSubview(bottomStackView)
        labelsToBottomStackView()
    }
    
    private func labelsToBottomStackView() {
        bottomStackView.addArrangedSubview(phoneLabel)
        bottomStackView.addArrangedSubview(faxLabel)
        bottomStackView.addArrangedSubview(webSiteLabel)
    }
    
    func setupConstraints() {
        leftImageBackgroundViewConstraints()
        leftImageViewConstraints()
        cityCountyLabelConstraints()
        nameLabelConstraints()
        streetLabelConstraints()
        bottomStackViewConstraints()
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
    
    private func streetLabelConstraints() {
        streetLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.height.equalTo(streetLabel.font.lineHeight)
            make.leading.trailing.equalTo(nameLabel)
        }
    }
    
    private func bottomStackViewConstraints() {
        bottomStackView.snp.makeConstraints { make in
            make.top.equalTo(streetLabel.snp.bottom).offset(10)
            make.height.equalTo(streetLabel.font.lineHeight)
            make.leading.trailing.equalTo(streetLabel)
            
        }
    }
    
    
}

