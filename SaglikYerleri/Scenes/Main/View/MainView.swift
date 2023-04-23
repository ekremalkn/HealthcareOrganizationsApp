//
//  MainView.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 21.04.2023.
//

import UIKit
import SnapKit

final class MainView: UIView {
    
    //MARK: - Creating UI Elements
    lazy var navBarLeftButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
        return button
    }()
    
    lazy var topView = CustomTopView()
    
    lazy var verticalCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: MainView.createCompositionalLayout())
        collection.register(VerticalCollectionCell.self, forCellWithReuseIdentifier: VerticalCollectionCell.identifier)
        collection.backgroundColor = UIColor(hex: "FBFCFE")
        collection.showsVerticalScrollIndicator = false
        return collection
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

//MARK: - Creating  Collection Compositional Layout
extension MainView {
    static func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        // Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.6),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let verticalStackItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.5)
            )
        )
        
        verticalStackItem.contentInsets = item.contentInsets
        
        var verticalStackGroup: NSCollectionLayoutGroup
        
        if #available(iOS 16.0, *) {
            verticalStackGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.4),
                    heightDimension: .fractionalHeight(1)
                ),
                repeatingSubitem: verticalStackItem,
                count: 2
            )
        } else {
            // Fallback on earlier versions
            verticalStackGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.4),
                    heightDimension: .fractionalHeight(1)
                ),
                subitem: verticalStackItem,
                count: 2
            )
        }
        
        // Group
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.8)
            ),
            subitems: [
            item,
            verticalStackGroup
            ]
        )
        
        // Sections
        let sections = NSCollectionLayoutSection(group: group)
        
        // Return
        return UICollectionViewCompositionalLayout(section: sections)
    }
}

//MARK: - UI Elements AddSubview / SetupConstraints
extension MainView: ViewProtocol {
    func configureView() {
        backgroundColor = UIColor(hex: "FBFCFE")
        addSubview()
        setupConstraints()
    }
    
    func addSubview() {
        addSubview(topView)
        addSubview(verticalCollectionView)
    }
    
    func setupConstraints() {
        topViewConstraints()
        collectionViewConstraints()
    }
    
    private func topViewConstraints() {
        topView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalTo(self)
            make.height.equalTo(self.snp.height).multipliedBy(0.5)
        }
    }
    
    private func collectionViewConstraints() {
        verticalCollectionView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.leading.bottom.trailing.equalTo(self)
        }
        
    }
    
    
}
