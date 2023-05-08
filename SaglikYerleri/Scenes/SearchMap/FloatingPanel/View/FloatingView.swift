//
//  FloatingView.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 5.05.2023.
//

import UIKit

final class FloatingView: UIView {
    
    //MARK: - Creating UI Elements
    lazy var placesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PharmacyCell.self, forCellReuseIdentifier: PharmacyCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell1")
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    
    
    
}

//MARK: - UI Elements AddSubview / SetupConstraints
extension FloatingView: ViewProtocol {
    func configureView() {
        addSubview()
        setupConstraints()
    }
    
    func addSubview() {
        addSubview(placesTableView)
    }
    
    func setupConstraints() {
        placesTableViewConstraints()
    }
    
    private func placesTableViewConstraints() {
        placesTableView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    
}

