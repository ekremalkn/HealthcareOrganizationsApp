//
//  MRHHCell.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 9.05.2023.
//

import UIKit

protocol SharedCell1DataProtocol where Self: Codable {
    var sharedCell1ImageBackgroundColor: UIColor { get }
    var sharedCell1Image: UIImage { get }
    var sharedCell1Name: String { get }
    var sharedCell1CityCountyName: String { get }
    var sharedCell1Address: String { get }
    var sharedCell1Phone: String { get }
    var sharedCell1Email: String { get }
}

final class SharedCell1: UITableViewCell {
    static let identifier = "SharedCell1"
    
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

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        label.backgroundColor = .blue
        return label
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        label.alpha = 0
        return label
    }()

    lazy var buttonStackView: UIStackView = {
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
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2) { [unowned self] in
                    self.addressLabel.alpha = self.isExpanded ? 1 : 0
                    self.buttonStackView.alpha = self.isExpanded ? 1 : 0
                    self.expandImageView.transform = self.isExpanded ? CGAffineTransform(rotationAngle: CGFloat.pi) : .identity
                    self.nameLabel.transform = self.isExpanded ? CGAffineTransform(translationX: 0, y: -15) : .identity
                    self.addressLabel.transform = self.isExpanded ? CGAffineTransform(translationX: 0, y: -15) : .identity
                    
                }
                
                UIView.animate(withDuration: 0.4) {
                    self.buttonStackView.transform = self.isExpanded ? CGAffineTransform(translationX: 0, y: 15) : .identity
                }
            }
            self.isExpanded ? self.nameLabelConstraints(type: .updateConstraints(true)) : nil
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
    
    func configure(with data: SharedCell1DataProtocol) {
        leftImageBackgroundView.backgroundColor = data.sharedCell1ImageBackgroundColor.withAlphaComponent(0.2)
        leftImageView.image = data.sharedCell1Image
        nameLabel.text = data.sharedCell1Name.localizedCapitalized
        addressLabel.text = data.sharedCell1Address
        nameLabelConstraints(type: .updateConstraints(true))
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

//MARK: - UI Element AddSubview / SetupConstraints
extension SharedCell1: CellProtocol {
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
        contentView.addSubview(addressLabel)
        contentView.addSubview(buttonStackView)
        buttonsToStackView()
    }
    
    private func buttonsToStackView() {
        buttonStackView.addArrangedSubview(callButton)
        buttonStackView.addArrangedSubview(sendMailButton)
        buttonStackView.addArrangedSubview(locationButton)
    }
    
    func setupConstraints() {
        leftImageBackgroundViewConstraints()
        leftImageViewConstraints()
        expandImageViewConstraints()
        nameLabelConstraints(type: .makeConstraints)
        buttonStackViewConstraints()
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
    
    private func nameLabelConstraints(type constraintsType: ConstraintsType) {
        switch constraintsType {
        case .updateConstraints(let bool):
            if bool {
                addressLabel.snp.updateConstraints { make in
                    make.top.equalTo(nameLabel.snp.bottom).offset(10)
                    make.leading.trailing.equalTo(nameLabel)
                }
                
            }
        case .makeConstraints:
            nameLabel.snp.makeConstraints { make in
                make.centerY.equalTo(leftImageBackgroundView.snp.centerY)
                make.leading.equalTo(leftImageBackgroundView.snp.trailing).offset(10)
                make.trailing.equalTo(contentView.snp.trailing).offset(-10)
            }
        }
        
    }
    
    private func buttonStackViewConstraints() {
        buttonStackView.snp.makeConstraints { make in
            make.width.equalTo(contentView.snp.width)
            make.top.equalTo(addressLabel.snp.bottom)
            make.height.equalTo(50)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
    }

}
