//
//  RecentSearchesFooterView.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 26.05.2023.
//

import UIKit

final class RecentSearchesFooterView: UIView {
    deinit {
        print("RecentSearchesFooterView deinit")
    }
    //MARK: - Creating UI Elements
    let filterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //register cell
        collection.register(SelectedCityCountyCell.self, forCellWithReuseIdentifier: SelectedCityCountyCell.identifier)
        collection.backgroundColor = .white
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
    
    private func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize.init(width: 3, height: 3)
    }
    
}

extension RecentSearchesFooterView: ViewProtocol {
    func configureView() {
        backgroundColor = .white
        addShadow()
        addSubview()
        setupConstraints()
    }
    
    func addSubview() {
        addSubview(filterCollectionView)
    }
    
    func setupConstraints() {
        filterCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    
}
