//
//  SearchResultView.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 2.05.2023.
//

import UIKit

public enum SearchResultAnimateState {
    case toTop
    case toBottom
}

final class SearchResultView: UIView {
    
    //MARK: - Creating UI Elements
    lazy var selectedCityCountyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(SelectedCityCountyCell.self, forCellWithReuseIdentifier: SelectedCityCountyCell.identifier)
        collection.backgroundColor = .clear
        return collection
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        table.backgroundColor = UIColor(hex: "FBFCFE")
        return table
    }()
    
    //MARK: - Init methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.layer.cornerRadius = 8
        tableView.layer.masksToBounds = true
    }
    
}

//MARK: - UI Elements AddSubview / Setup Constraints

extension SearchResultView: ViewProtocol {
    func configureView() {
        backgroundColor = .clear
        addSubview()
        setupConstraints()
    }
    
    func addSubview() {
        addSubview(tableView)
    }
    
    
    func setupConstraints() {
        tableViewConstraints()
    }
    
    private func tableViewConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.centerY)
            make.leading.equalTo(safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-10)
        }
    }
    
    func needSelectedItemCollectionView(animateState: SearchResultAnimateState, completion: @escaping (() -> Void)) {
        switch animateState {
        case .toTop:
            self.animateTableAndCollection(animateState: animateState) {
                completion()
            }
        case .toBottom:
            addSubview(selectedCityCountyCollectionView)
            
            selectedCityCountyCollectionView.snp.makeConstraints { make in
                make.top.equalTo(safeAreaLayoutGuide.snp.top)
                make.height.equalTo(0)
                make.leading.trailing.equalTo(tableView)
            }
            
            self.animateTableAndCollection(animateState: animateState) {
                completion()
            }
        }
        
    }
    
    func animateTableAndCollection(animateState: SearchResultAnimateState, completion: @escaping (() -> Void)) {
        var tableFrame = tableView.frame
        
        switch animateState {
        case .toTop:
            selectedCityCountyCollectionView.snp.removeConstraints()
            
            tableView.snp.updateConstraints { make in
                make.top.equalTo(safeAreaLayoutGuide.snp.top)
            }
            
            tableFrame.origin.y -= 55
        case .toBottom:
            tableView.snp.updateConstraints { make in
                make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(55)
            }
            
            selectedCityCountyCollectionView.snp.updateConstraints { make in
                make.height.equalTo(50)
            }
            
            tableFrame.origin.y += 55
            
        }
        
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.tableView.frame = tableFrame
            self?.selectedCityCountyCollectionView.layoutIfNeeded()
            completion()
        }
        
        
    }
    
}
