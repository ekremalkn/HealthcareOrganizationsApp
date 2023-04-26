//
//  VerticalCollectionCell.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 23.04.2023.
//

import UIKit

final class VerticalCollectionCell: UICollectionViewCell {
    static let identifier = "VerticalCollectionCell"
    
    //MARK: - Creating UI Elements
    private lazy var categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
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
        layer.cornerRadius = 12
        contentView.layer.cornerRadius = 12
    }

    
    func configure(with data: MainCollectionData) {
        self.categoryTitleLabel.text = data.categoryTitle
        self.contentView.backgroundColor = data.bacgroundColor
    }
    
}

//MARK: - UI Elements AddSubview / Setup Constraints
extension VerticalCollectionCell: CellProtocol {
    func configureCell() {
        addSubview()
        setupConstraints()
    }
    
    func addSubview() {
        contentView.addSubview(categoryTitleLabel)
    }
    
    func setupConstraints() {
        categoryTitleLabelConstraints()
    }
    
    private func categoryTitleLabelConstraints() {
        categoryTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).offset(10)
            make.bottom.trailing.equalTo(contentView).offset(-10)
        }
    }
    
    
}
