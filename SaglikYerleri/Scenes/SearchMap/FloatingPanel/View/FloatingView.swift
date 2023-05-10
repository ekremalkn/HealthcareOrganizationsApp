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
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(hex: "FBFCFE")
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        makeCornerRadius()
    }
    
    private func makeCornerRadius() {
        clipsToBounds = true
        layer.cornerRadius = 12
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Only Top Left-Right
    }
    
    
}

//MARK: - UI Elements AddSubview / SetupConstraints
extension FloatingView: ViewProtocol {
    func configureView() {
        backgroundColor = UIColor(hex: "FBFCFE")
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

