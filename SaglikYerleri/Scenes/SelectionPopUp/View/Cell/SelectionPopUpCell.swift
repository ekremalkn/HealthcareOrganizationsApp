//
//  SelectionPopUpCell.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 2.06.2023.
//

import UIKit

final class SelectionPopUpCell: UICollectionViewCell {
    static let identifier = "SelectionPopUpCell"
    
    //MARK: - Creating UI Elements
    lazy var imageViewBackgroundView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var selectionImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    lazy var selectionTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    //MARK: - Cell IsSelected
    override var isSelected: Bool {
        get {
            return super.isSelected //default false
        }
        
        set {
            if super.isSelected != newValue {
                super.isSelected = newValue
                
                if newValue {
                    animateBorderCellSelected()
                } else {
                    reverseBorderAnimation()
                    
                }
            }
        }
    }
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        addShadow()
        contentView.layer.cornerRadius = 45
        contentView.clipsToBounds = true
        contentView.layer.masksToBounds = true
        
        imageViewBackgroundView.layer.cornerRadius = 27
        imageViewBackgroundView.clipsToBounds = true
        
    }
    
    func configure(with data: MainHorizontalCollectionData) {
        imageViewBackgroundView.backgroundColor = .init(hex: data.tintAndBackgroundColor).withAlphaComponent(0.2)
        selectionImageView.image = .init(named: data.image)
        selectionImageView.tintColor = .init(hex: data.tintAndBackgroundColor)
        selectionTitleLabel.text = data.categoryTitle
    }
    
    private func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize.init(width: 3, height: 3)
    }
    
    func animateBorderCellSelected() {
        
        let borderWidth: CGFloat = 4
        let borderColor: UIColor = .init(hex: "6279E0").withAlphaComponent(0.5)
        
        // borders shapelayer
        let borderLayer = CAShapeLayer()
        borderLayer.shadowColor = UIColor.init(hex: "6279E0").cgColor
        borderLayer.shadowOpacity = 1
        borderLayer.shadowOffset = CGSize.init(width: 5, height: 5)
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = contentView.bounds
        
        // circle uibezierpath
        let radius = min(contentView.bounds.width, contentView.bounds.height) / 2
        let center = CGPoint(x: contentView.bounds.midX, y: contentView.bounds.midY)
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        borderLayer.path = path.cgPath
        
        // shape layeri ekle
        contentView.layer.addSublayer(borderLayer)
        
        // animasyon oluştur
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 0.5
        
        // animasyonu çerçeve katmanına ekle
        borderLayer.add(animation, forKey: "drawBorderAnimation")
    }
    
    func reverseBorderAnimation() {
        guard let borderLayer = contentView.layer.sublayers?.first(where: { $0 is CAShapeLayer }) as? CAShapeLayer else {
            return
        }
        
        // Animasyonu tersine doğru oynatın
        let reverseAnimation = CABasicAnimation(keyPath: "strokeEnd")
        reverseAnimation.fromValue = 1.0
        reverseAnimation.toValue = 0.0
        reverseAnimation.duration = 0.5
        
        // Animasyonu çerçeve katmanına uygulayın
        borderLayer.add(reverseAnimation, forKey: "reverseBorderAnimation")
        
        // Animasyonun tamamlandığını takip etmek için bir closure kullanın
        borderLayer.removeFromSuperlayer()
        
    }
}

extension SelectionPopUpCell: CellProtocol {
    func configureCell() {
        contentView.backgroundColor = .white
        addSubview()
        setupConstraints()
    }
    
    func addSubview() {
        contentView.addSubview(imageViewBackgroundView)
        imageViewBackgroundView.addSubview(selectionImageView)
        self.addSubview(selectionTitleLabel)
    }
    
    func setupConstraints() {
        contentViewConstraints()
        imageViewBackgroundViewConstraints()
        selectionImageViewConstraints()
        selectionTitleLabelConstraints()
    }
    
    private func contentViewConstraints() {
        contentView.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.snp.top)
            make.height.width.equalTo(90)
        }
    }
    
    private func imageViewBackgroundViewConstraints() {
        imageViewBackgroundView.snp.makeConstraints { make in
            make.center.equalTo(contentView.snp.center)
            make.height.width.equalTo(contentView.snp.height).multipliedBy(0.6)
        }
    }
    
    private func selectionImageViewConstraints() {
        selectionImageView.snp.makeConstraints { make in
            make.center.equalTo(imageViewBackgroundView.snp.center)
            make.height.width.equalTo(imageViewBackgroundView.snp.height).multipliedBy(0.6)
        }
    }
    
    private func selectionTitleLabelConstraints() {
        selectionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.bottom).offset(5)
            make.bottom.equalTo(self.snp.bottom)
            make.centerX.equalTo(contentView.snp.centerX)
            make.leading.equalTo(self.snp.leading).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
        }
    }
    
    
}
