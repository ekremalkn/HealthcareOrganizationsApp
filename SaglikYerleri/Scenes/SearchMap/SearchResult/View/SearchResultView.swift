//
//  SearchResultView.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 2.05.2023.
//

import UIKit

final class SearchResultView: UIView {
    
    //MARK: - Creating UI Elements
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
    
}
