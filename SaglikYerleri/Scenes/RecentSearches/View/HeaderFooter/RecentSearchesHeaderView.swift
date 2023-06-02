//
//  RecentSearchesHeaderView.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 26.05.2023.
//

import UIKit

final class RecentSearchesHeaderView: UIView {
    deinit {
        print("RecentSearchesHeaderView deinit")
    }
    //MARK: - Creating UI Elements
    private let leftLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Medium", size: 15)
        label.textColor = .darkGray
        label.textAlignment = .left
        return label
    }()
    
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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

extension RecentSearchesHeaderView: ViewProtocol {
    func configureView() {
        backgroundColor = .white
        addShadow()
        addSubview()
        setupConstraints()
    }
    
    func addSubview() {
        addSubview(leftLabel)
    }
    
    func setupConstraints() {
        leftLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(20)
            make.trailing.equalTo(self.snp.trailing).offset(-20)
            make.height.equalTo(self.snp.height)
        }
    }
    
    
    
}
