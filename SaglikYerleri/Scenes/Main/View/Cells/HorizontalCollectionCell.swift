//
//  HorizontalCollectionCell.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 22.04.2023.
//

import UIKit

final class HorizontalCollectionCell: UICollectionViewCell {
    static let identifier = "HorizontalCollectionCell"
    
    //MARK: - Creating UI Elements
    private lazy var imageBackgroundView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "282D3C")
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layout Subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 8
        
        imageBackgroundView.layer.cornerRadius = (contentView.frame.height * 0.4) / 2
        imageBackgroundView.clipsToBounds = true
    }
    
    func configure(with data: MainHorizontalCollectionData) {
        imageBackgroundView.backgroundColor = data.tintAndBackgroundColor.withAlphaComponent(0.2)
        categoryImageView.image = data.image
        categoryImageView.tintColor = data.tintAndBackgroundColor
        categoryLabel.text = data.categoryTitle
        
    }
    
    private func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize.init(width: 3, height: 3)
    }
}

//MARK: - UI Elements AddSubview / SetupConstraints
extension HorizontalCollectionCell: CellProtocol {
    func configureCell() {
        backgroundColor = .white
        addShadow()
        addSubview()
        setupConstraints()
    }
    
    func addSubview() {
        contentView.addSubview(imageBackgroundView)
        imageBackgroundView.addSubview(categoryImageView)
        contentView.addSubview(categoryLabel)
    }
    
    func setupConstraints() {
        imageBackgroundViewConstraints()
        categoryImageViewConstraints()
        categoryLabelConstraints()
    }
    
    private func imageBackgroundViewConstraints() {
        imageBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
            make.height.width.equalTo(contentView.snp.height).multipliedBy(0.40)
        }
    }
    
    private func categoryImageViewConstraints() {
        categoryImageView.snp.makeConstraints { make in
            make.center.equalTo(imageBackgroundView.snp.center)
            make.height.width.equalTo(imageBackgroundView.snp.height).multipliedBy(0.60)
        }
    }
    
    private func categoryLabelConstraints() {
        categoryLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
            make.trailing.equalTo(categoryImageView.snp.trailing)
            make.top.equalTo(categoryImageView.snp.bottom).offset(7)
        }
    }
    
}
