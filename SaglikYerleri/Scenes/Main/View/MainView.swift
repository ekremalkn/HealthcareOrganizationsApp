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
    
    lazy var mainCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: MainView.createCompositionalLayout())
        collection.register(VerticalCollectionCell.self, forCellWithReuseIdentifier: VerticalCollectionCell.identifier)
        collection.register(MainCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainCollectionHeaderView.identifier)
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
        
        // Vertical Group
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
                heightDimension: .fractionalHeight(0.3)
            ),
            subitems: [
                item,
                verticalStackGroup
            ]
        )
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        let sections = NSCollectionLayoutSection(group: group)
        sections.boundarySupplementaryItems = [header]
        
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
        addSubview(mainCollectionView)
    }
    
    func setupConstraints() {
        collectionViewConstraints()
    }
    
    private func collectionViewConstraints() {
        mainCollectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.bottom.trailing.equalTo(self)
        }
        
    }
    
    
}
