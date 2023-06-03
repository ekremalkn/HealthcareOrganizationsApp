//
//  ProfileCell.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 30.05.2023.
//

import UIKit

final class ProfileCell: UITableViewCell {
    static let identifier = "ProfileCell"
    deinit {
        print("ProfileCell  deinit")
    }
    //MARK: - Creating UI Elements
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var keyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 15)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .darkGray
        imageView.image = .init(systemName: "chevron.right")
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    
    
    //MARK: - Init Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        keyLabel.textColor = .black
        isUserInteractionEnabled = true
    }
    
    func configure(with data: (key: String, value: String)) {
        keyLabel.text = data.key
        valueLabel.text = data.value
    }
    
    func configureButtonTitle(with title: String, interaction: Bool, buttonTintColor: String) {
        keyLabel.text = title
        rightImageView.isHidden = false
        if interaction {
            keyLabel.textColor = .init(hex: buttonTintColor)
        } else {
            keyLabel.textColor = .init(hex: buttonTintColor)
            isUserInteractionEnabled = false
        }
    }
    
}

extension ProfileCell: CellProtocol {
    func configureCell() {
        separatorInset = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 0)
        backgroundColor = .white
        addSubview()
        setupConstraints()
    }
    
    func addSubview() {
        contentView.addSubview(labelStackView)
        labelStackView.addArrangedSubview(keyLabel)
        labelStackView.addArrangedSubview(valueLabel)
        labelStackView.addSubview(rightImageView)
    }
    
    func setupConstraints() {
        labelStackView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(18)
            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
            make.top.bottom.equalTo(contentView)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.trailing.equalTo(labelStackView.snp.trailing).offset(-7)
            make.height.width.equalTo(20)
            make.centerY.equalTo(labelStackView.snp.centerY)
        }
    }
    
    
}
