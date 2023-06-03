//
//  RecentSearchesView.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 26.05.2023.
//

import UIKit

final class RecentSearchesView: UIView {
    deinit {
        print("RecentSearchesView deinit")
    }
    //MARK: - Creating UI Elements
    lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "Ana Menü"
        button.tintColor = .init(hex: "6279E0")
        return button
    }()
    
    let recentSearchesTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .init(hex: "FBFCFE")
        tableView.register(PharmacyCell.self, forCellReuseIdentifier: PharmacyCell.identifier)
        tableView.register(SharedCell1.self, forCellReuseIdentifier: SharedCell1.identifier)
        tableView.register(SharedCell2.self, forCellReuseIdentifier: SharedCell2.identifier)
        return tableView
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

extension RecentSearchesView: ViewProtocol {
    func configureView() {
        backgroundColor = .init(hex: "FBFCFE")
        addSubview()
        setupConstraints()
    }
    
    func addSubview() {
        addSubview(recentSearchesTableView)
    }
    
    func setupConstraints() {
        recentSearchesTableView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalTo(self)
        }
    }
    
    
}
