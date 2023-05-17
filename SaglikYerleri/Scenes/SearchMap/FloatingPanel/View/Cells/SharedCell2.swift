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
    
    private lazy var expandImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var streetLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 3
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.distribution = .equalSpacing
        stackView.alpha = 0
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var callButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "callButton"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private lazy var sendMailButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "sendMailButton"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private lazy var locationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "locationButton"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    var isExpanded: Bool = false {
        didSet {
            UIView.animate(withDuration: 0.2) { [unowned self] in
                self.buttonStackView.alpha = self.isExpanded ? 1 : 0
                self.expandImageView.transform = self.isExpanded ? CGAffineTransform(rotationAngle: CGFloat.pi) : .identity
            }
        }
    }
    
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
        nameLabel.text = data.sharedCell2Name
        streetLabel.text = data.sharedCell2Street

    }
    
    private func addShadow() {
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize.init(width: 3, height: 5)
    }
    
    private func makeCornerRadius() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10))
        contentView.layer.cornerRadius = 12
        
        leftImageBackgroundView.layer.cornerRadius = 29
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
        contentView.addSubview(expandImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(streetLabel)
    }
    
    func setupConstraints() {
        leftImageBackgroundViewConstraints()
        leftImageViewConstraints()
        expandImageViewConstraints()
        nameLabelConstraints()
        streetLabelConstraints()
    }
    
    private func leftImageBackgroundViewConstraints() {
        leftImageBackgroundView.snp.makeConstraints { make in
            make.leading.top.equalTo(contentView).offset(10)
            make.height.width.equalTo(58)
        }
    }
    
    private func leftImageViewConstraints() {
        leftImageView.snp.makeConstraints { make in
            make.center.equalTo(leftImageBackgroundView.snp.center)
            make.height.width.equalTo(leftImageBackgroundView.snp.height).multipliedBy(0.6)
        }
    }
    
    private func expandImageViewConstraints() {
        expandImageView.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
            make.top.equalTo(leftImageBackgroundView.snp.top)
            make.height.equalTo(17)
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
    
    
}

