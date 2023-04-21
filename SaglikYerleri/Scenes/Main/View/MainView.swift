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
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor(hex: "FBFCFE")
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
