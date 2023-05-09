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
        tableView.backgroundColor = UIColor(hex: "FBFCFE")
        tableView.register(PharmacyCell.self, forCellReuseIdentifier: PharmacyCell.identifier)
        tableView.register(MRHHCell.self, forCellReuseIdentifier: MRHHCell.identifier)
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

