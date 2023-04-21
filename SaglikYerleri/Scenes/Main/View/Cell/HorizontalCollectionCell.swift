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
    private lazy var categoryImageView: UIImageView = {
        let imageView = UIImageView()
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 8
    }
    
    func configure(with data: MainHorizontalCollectionData) {
        self.categoryImageView.image = data.image
        self.categoryLabel.text = data.categoryTitle
    }
    
    private func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize.zero
    }
}

extension HorizontalCollectionCell: CellProtocol {
    func configureCell() {
        backgroundColor = .white
        addShadow()
        addSubview()
        setupConstraints()
    }
    
    func addSubview() {
        contentView.addSubview(categoryImageView)
        contentView.addSubview(categoryLabel)
    }
    
    func setupConstraints() {
        categoryImageViewConstraints()
        categoryLabelConstraints()
    }
    
    private func categoryImageViewConstraints() {
        categoryImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.25)
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
