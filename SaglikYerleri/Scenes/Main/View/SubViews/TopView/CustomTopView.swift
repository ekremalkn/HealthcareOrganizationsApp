//
//  CustomTopView.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 21.04.2023.
//

import UIKit

final class CustomTopView: UIView {
    
    //MARK: - Creating UI Elements
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Arama yap ya da sık arananlardan devam et"
        label.textColor = UIColor(hex: "282D3C")
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var textField = CustomTextField()
    
    private lazy var topSearchedLabel: UILabel = {
        let label = UILabel()
        label.text = "Sık arananlar"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor(hex: "282D3C")
        label.textAlignment = .left
        return label
    }()
    
    lazy var horizontalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        collection.register(HorizontalCollectionCell.self, forCellWithReuseIdentifier: HorizontalCollectionCell.identifier)
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    private lazy var categoriesLabel: UILabel = {
        let label = UILabel()
        label.text = "Sağlık kuruluşları"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor(hex: "282D3C")
        label.textAlignment = .left
        return label
    }()
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

//MARK: - UI Elements AddSubview / SetupConstraints
extension CustomTopView: ViewProtocol {
    func configureView() {
        backgroundColor = UIColor(hex: "FBFCFE")
        addSubview()
        setupConstraints()
    }
    
    func addSubview() {
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(topSearchedLabel)
        addSubview(horizontalCollectionView)
        addSubview(categoriesLabel)
    }
    
    func setupConstraints() {
        titleLabelConstraints()
        searchBarConstraints()
        topSearchedLabelConstraints()
        horizontalCollectionViewConstraints()
        categoriesLabelConstraints()
    }
    
    private func titleLabelConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(self.snp.width).offset(-70)
            make.height.equalTo(self.snp.height).multipliedBy(0.25)
        }
    }
    
    private func searchBarConstraints() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.centerX.equalTo(titleLabel.snp.centerX)
            make.width.equalTo(titleLabel.snp.width).offset(10)
            make.height.equalTo(self.snp.height).multipliedBy(0.15)
        }
    }
    
    private func topSearchedLabelConstraints() {
        topSearchedLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(5)
            make.leading.trailing.equalTo(textField)
            make.height.equalTo(self.snp.height).multipliedBy(0.10)
        }
    }
    
    private func horizontalCollectionViewConstraints() {
        horizontalCollectionView.snp.makeConstraints { make in
            make.top.equalTo(topSearchedLabel.snp.bottom).offset(5)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing).offset(20)
            make.height.equalTo(self.snp.height).multipliedBy(0.30)
        }
    }
    
    private func categoriesLabelConstraints() {
        categoriesLabel.snp.makeConstraints { make in
            make.top.equalTo(horizontalCollectionView.snp.bottom).offset(5)
            make.leading.trailing.equalTo(topSearchedLabel)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
}
