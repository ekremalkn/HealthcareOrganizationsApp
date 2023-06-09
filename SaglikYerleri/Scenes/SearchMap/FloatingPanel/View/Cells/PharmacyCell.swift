//
//  PharmacyCell.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 8.05.2023.
//

import UIKit
import RxSwift
import CoreLocation
import MapKit

enum ConstraintsType {
    case updateConstraints(Bool)
    case makeConstraints
}

protocol PharmacyCellDataProtocol {
    var pharmacyImageBackgroundColor: String { get }
    var pharmacyImage: String { get }
    var pharmacyName: String { get }
    var pharmacyAddress: String { get }
    var pharmacyPhone1: String { get }
    var pharmacyPhone2: String { get }
    var pharmacyDirections: String { get}
    var pharmacyLat: Double { get }
    var pharmacyLng: Double { get }
}

final class PharmacyCell: UITableViewCell {
    static let identifier = "PharmacyCell"
    
    //MARK: - Creating UI Elements
    lazy var leftImageBackgroundView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var expandImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        label.alpha = 0
        return label
    }()
    
    lazy var directionsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 3
        label.textColor = .black
        label.textAlignment = .left
        label.alpha = 0
        return label
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alpha = 0
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var callButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "callButton"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize.init(width: 3, height: 5)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "shareButton"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize.init(width: 3, height: 5)
        return button
    }()
    
    private lazy var locationButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "locationButton"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize.init(width: 3, height: 5)
        return button
    }()
    
    var isExpanded: Bool = false {
        didSet {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2) { [unowned self] in
                    self.buttonStackView.alpha = self.isExpanded ? 1 : 0
                    self.directionsLabel.alpha = self.isExpanded ? 1 : 0
                    self.addressLabel.alpha = self.isExpanded ? 1 : 0
                    
                    self.expandImageView.transform = self.isExpanded ? CGAffineTransform(rotationAngle: CGFloat.pi) : .identity
                    self.nameLabel.transform = self.isExpanded ? CGAffineTransform(translationX: 0, y: -15) : .identity
                    self.addressLabel.transform = self.isExpanded ? CGAffineTransform(translationX: 0, y: -15) : .identity
                    self.directionsLabel.transform = self.isExpanded ? CGAffineTransform(translationX: 0, y: -15) : .identity
                }
                
                UIView.animate(withDuration: 0.8) {
                    self.buttonStackView.transform = self.isExpanded ? CGAffineTransform(translationX: -self.contentView.frame.width * 0.875, y: 10) : .identity
                    self.callButton.transform = self.isExpanded ? CGAffineTransform(rotationAngle: -.pi ) : .identity
                    self.locationButton.transform = self.isExpanded ? CGAffineTransform(rotationAngle: -.pi ) : .identity
                    self.shareButton.transform = self.isExpanded ? CGAffineTransform(rotationAngle: -.pi ) : .identity
                }
            }
            self.isExpanded ? self.nameLabelConstraints(type: .updateConstraints(true)) : nil
        }
    }
    
    //MARK: - Dispose Bag
    private (set) var disposeBag = DisposeBag()
    
    
    //MARK: - Observables
    var contentToShare = PublishSubject<(String, String, String ,String, MKMapItem)>()
    var didtapLocationButton: Observable<Void> {
        return self.locationButton.rx.tap.asObservable()
    }
    
    //MARK: - Variables
    var organizationInfo: (CLLocationCoordinate2D, String)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        makeCornerRadius()
    }
    
    func configureCell() {
        backgroundColor = .white
        contentView.backgroundColor = UIColor(hex: "FBFCFE")
        addShadow()
        addSubview()
        setupConstraints()
        setButtonActions()
    }
    
    func configure(with data: PharmacyCellDataProtocol) {
        organizationInfo = (CLLocationCoordinate2D(latitude: data.pharmacyLat, longitude: data.pharmacyLng), data.pharmacyName)
        createContentToShare(with: data)
        leftImageBackgroundView.backgroundColor = .init(hex: data.pharmacyImageBackgroundColor).withAlphaComponent(0.2)
        leftImageView.image = .init(named: data.pharmacyImage)
        nameLabel.text = data.pharmacyName.localizedCapitalized
        addressLabel.text = data.pharmacyAddress
        directionsLabel.text = data.pharmacyDirections
        buttonStackViewConstraints()
        nameLabelConstraints(type: .updateConstraints(true))
    }
    
    private func addShadow() {
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize.init(width: 3, height: 5)
    }
    
    private func makeCornerRadius() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10))
        contentView.layer.cornerRadius = 12
        
        leftImageBackgroundView.layer.cornerRadius = 29
    }
    
    //MARK: - Button Actions
    private func setButtonActions() {
        callButton.rx.makePhoneCall(phoneObservable: contentToShare, disposeBag: disposeBag)
        shareButton.rx.shareContent(contentObservable: contentToShare, disposeBag: disposeBag)
    }
    
    //MARK: - Create MKMapItem
    private func createContentToShare(with data: PharmacyCellDataProtocol) {
        let coordinate = CLLocationCoordinate2D(latitude: data.pharmacyLat, longitude: data.pharmacyLng)
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        contentToShare.onNext((data.pharmacyName, data.pharmacyAddress, data.pharmacyDirections, data.pharmacyPhone1, mapItem))
        
    }
    
}

//MARK: - UI Element AddSubview / SetupConstraints
extension PharmacyCell: CellProtocol {
    func addSubview() {
        contentView.addSubview(leftImageBackgroundView)
        leftImageBackgroundView.addSubview(leftImageView)
        contentView.addSubview(expandImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(directionsLabel)
        contentView.addSubview(buttonStackView)
        buttonsToStackView()
    }
    
    func buttonsToStackView() {
        buttonStackView.addArrangedSubview(callButton)
        buttonStackView.addArrangedSubview(locationButton)
        buttonStackView.addArrangedSubview(shareButton)
    }
    
    func setupConstraints() {
        leftImageBackgroundViewConstraints()
        leftImageViewConstraints()
        expandImageViewConstraints()
        nameLabelConstraints(type: .makeConstraints)
    }
    
    private func leftImageBackgroundViewConstraints() {
        leftImageBackgroundView.snp.makeConstraints { make in
            make.leading.top.equalTo(contentView).offset(10)
            make.height.width.equalTo(58)
        }
    }
    
    private func leftImageViewConstraints() {
        leftImageView.snp.makeConstraints { make in
            make.center.equalTo(leftImageBackgroundView.snp.center)
            make.height.width.equalTo(leftImageBackgroundView.snp.height).multipliedBy(0.6)
        }
    }
    
    private func expandImageViewConstraints() {
        expandImageView.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
            make.top.equalTo(leftImageBackgroundView.snp.top)
            make.height.width.equalTo(17)
        }
    }
    
    private func nameLabelConstraints(type constraintsType: ConstraintsType) {
        switch constraintsType {
        case .updateConstraints(let bool):
            if bool {
                addressLabel.snp.updateConstraints { make in
                    make.top.equalTo(nameLabel.snp.bottom).offset(10)
                    make.leading.equalTo(nameLabel.snp.leading)
                    make.trailing.equalTo(contentView.snp.trailing).offset(-10)
                }
                
                directionsLabel.snp.updateConstraints { make in
                    make.top.equalTo(addressLabel.snp.bottom).offset(10)
                    make.leading.trailing.equalTo(addressLabel)
                }
                
            }
        case .makeConstraints:
            nameLabel.snp.makeConstraints { make in
                make.centerY.equalTo(leftImageBackgroundView.snp.centerY)
                make.leading.equalTo(leftImageBackgroundView.snp.trailing).offset(10)
                make.trailing.equalTo(contentView.snp.trailing).offset(-27)
            }
        }
        
    }
    
    private func buttonStackViewConstraints() {
        if directionsLabel.text == "" || directionsLabel.text == nil {
            buttonStackView.snp.makeConstraints { make in
                make.width.equalTo(contentView.snp.width).multipliedBy(0.75)
                make.top.equalTo(addressLabel.snp.bottom)
                make.height.equalTo(50)
                make.leading.equalTo(contentView.snp.trailing)
            }
        } else {
            buttonStackView.snp.makeConstraints { make in
                make.width.equalTo(contentView.snp.width).multipliedBy(0.75)
                make.top.equalTo(directionsLabel.snp.bottom)
                make.height.equalTo(50)
                make.leading.equalTo(contentView.snp.trailing)
            }
            
        }
        
    }
    
    
}
