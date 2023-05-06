//
//  SelectedCityCountyCell.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 4.05.2023.
//

import UIKit

final class SelectedCityCountyCell: UICollectionViewCell {
    static let identifier = "SelectedCityCountyCell"
    
    //MARK: - Creating UI Elements
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    let xImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "multiply")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = contentView.frame.height / 2
        clipsToBounds = true
    }
    
    func configure(_ name: String) {
        self.nameLabel.text = name
    }
    
    
}

extension SelectedCityCountyCell: CellProtocol {
    func configureCell() {
        backgroundColor = UIColor(hex: "FBFCFE")
        addSubview()
        setupConstraints()
    }
    
    func addSubview() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(xImageView)
    }
    
    func setupConstraints() {
        nameLabelConstraints()
        xImageViewConstraints()
        
    }
    
    private func nameLabelConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(15)
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }
    
    private func xImageViewConstraints() {
        xImageView.snp.makeConstraints { make in
            make.trailing.equalTo(self.snp.trailing).offset(-10)
            make.height.width.equalTo(20)
            make.centerY.equalTo(nameLabel.snp.centerY)
        }
    }
    
}
