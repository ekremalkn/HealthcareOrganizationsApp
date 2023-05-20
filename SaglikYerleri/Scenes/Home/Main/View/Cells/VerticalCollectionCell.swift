//
//  VerticalCollectionCell.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 23.04.2023.
//

import UIKit


final class VerticalCollectionCell: UICollectionViewCell {
    static let identifier = "VerticalCollectionCell"
    
    //MARK: - Update or Make Constraints
    enum ConstraintsUpdateMake {
        case make
        case update
    }
    
    //MARK: - Creating UI Elements
    private lazy var categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
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
        contentView.layer.cornerRadius = 8
        self.layer.sublayers?.forEach({ layer in
            layer.cornerRadius = 8
        })
        categoryImageViewConstraints(do: .update)
    }
    
    func configure(with data: MainCollectionData) {
        categoryTitleLabel.text = data.categoryTitle
        applyGradient(colors: [data.secondBackgroundColor.cgColor, data.backgroundColor.cgColor])
        categoryImageView.image = data.image
        categoryImageView.tintColor = .white
        
    }
    
    
    
    
}

//MARK: - UI Elements AddSubview / Setup Constraints
extension VerticalCollectionCell: CellProtocol {
    func configureCell() {
        addSubview()
        setupConstraints()
    }
    
    func addSubview() {
        contentView.addSubview(categoryImageView)
        contentView.addSubview(categoryTitleLabel)
    }
    
    func setupConstraints() {
        categoryImageViewConstraints(do: .make)
        categoryTitleLabelConstraints()
    }
    
    private func categoryImageViewConstraints(do type: ConstraintsUpdateMake) {
        switch type {
        case .make:
            categoryImageView.snp.makeConstraints { make in
                if frame.height < 100 {
                    make.trailing.equalTo(contentView.snp.trailing).offset(-5)
                    make.top.equalTo(contentView.snp.top).offset(5)
                    make.height.width.equalTo(contentView.snp.height).multipliedBy(0.30)
                } else {
                    make.trailing.equalTo(contentView.snp.trailing).offset(-10)
                    make.top.equalTo(contentView.snp.top).offset(10)
                    make.height.width.equalTo(contentView.snp.height).multipliedBy(0.20)
                }
                
            }
        case .update:
            categoryImageView.snp.removeConstraints()
            categoryImageView.snp.updateConstraints { make in
                if frame.height < 100 {
                    make.trailing.equalTo(contentView.snp.trailing).offset(-5)
                    make.top.equalTo(contentView.snp.top).offset(5)
                    make.height.width.equalTo(contentView.snp.height).multipliedBy(0.30)
                } else {
                    make.trailing.equalTo(contentView.snp.trailing).offset(-10)
                    make.top.equalTo(contentView.snp.top).offset(10)
                    make.height.width.equalTo(contentView.snp.height).multipliedBy(0.20)
                }
                
            }
        }
        
    }
    
    
    private func categoryTitleLabelConstraints() {
        categoryTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).offset(10)
            make.bottom.trailing.equalTo(contentView).offset(-10)
        }
    }
    
    
}
