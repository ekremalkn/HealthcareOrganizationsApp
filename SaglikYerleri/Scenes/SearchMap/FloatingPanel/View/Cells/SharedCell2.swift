//
//  SharedCell2.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 10.05.2023.
//

import UIKit
import RxSwift
import CoreLocation
import MapKit

protocol SharedCell2DataProtocol {
    var sharedCell2ImageBackgroundColor: String { get }
    var sharedCell2Image: String { get }
    var sharedCell2Name: String { get }
    var sharedCell2Street: String { get }
    var sharedCell2Phone: String { get }
    var sharedCell2Fax: String { get }
    var sharedCell2WebSite: String { get }
    var sharedCell2Lat: Double { get }
    var sharedCell2Lng: Double { get }
}

final class SharedCell2: UITableViewCell {
    static let identifier = "SharedCell2"
    
    //MARK: - Creating UI Elements
    private lazy var leftImageBackgroundView: UIView = {
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
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    lazy var streetLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
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
                    self.streetLabel.alpha = self.isExpanded ? 1 : 0
                    self.buttonStackView.alpha = self.isExpanded ? 1 : 0
                    self.expandImageView.transform = self.isExpanded ? CGAffineTransform(rotationAngle: CGFloat.pi) : .identity
                    self.nameLabel.transform = self.isExpanded ? CGAffineTransform(translationX: 0, y: -15) : .identity
                    self.streetLabel.transform = self.isExpanded ? CGAffineTransform(translationX: 0, y: -15) : .identity
                    
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
    
    //MARK: - Init Methods
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
    
    func configure(with data: SharedCell2DataProtocol) {
        organizationInfo = (CLLocationCoordinate2D(latitude: data.sharedCell2Lat, longitude: data.sharedCell2Lng), data.sharedCell2Name)
        createContentToShare(with: data)
        leftImageBackgroundView.backgroundColor = .init(hex: data.sharedCell2ImageBackgroundColor).withAlphaComponent(0.2)
        leftImageView.tintColor = .init(hex: data.sharedCell2ImageBackgroundColor)
        leftImageView.image = .init(named: data.sharedCell2Image)
        nameLabel.text = data.sharedCell2Name.localizedCapitalized
        streetLabel.text = data.sharedCell2Street
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
    private func createContentToShare(with data: SharedCell2DataProtocol) {
        let coordinate = CLLocationCoordinate2D(latitude: data.sharedCell2Lat, longitude: data.sharedCell2Lng)
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        contentToShare.onNext((data.sharedCell2Name, data.sharedCell2Street, data.sharedCell2WebSite, data.sharedCell2Phone, mapItem))
    }
}

//MARK: - UI Elements AddSubview / SetupConstraints
extension SharedCell2: CellProtocol {
    func addSubview() {
        contentView.addSubview(leftImageBackgroundView)
        leftImageBackgroundView.addSubview(leftImageView)
        contentView.addSubview(expandImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(streetLabel)
        contentView.addSubview(buttonStackView)
        buttonsToStackView()
    }
    
    private func buttonsToStackView() {
        buttonStackView.addArrangedSubview(callButton)
        buttonStackView.addArrangedSubview(locationButton)
        buttonStackView.addArrangedSubview(shareButton)
    }
    
    func setupConstraints() {
        leftImageBackgroundViewConstraints()
        leftImageViewConstraints()
        expandImageViewConstraints()
        nameLabelConstraints(type: .makeConstraints)
        buttonStackViewConstraints()
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
                streetLabel.snp.updateConstraints { make in
                    make.top.equalTo(nameLabel.snp.bottom).offset(10)
                    make.height.equalTo(streetLabel.font.lineHeight)
                    make.leading.trailing.equalTo(nameLabel)
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
        buttonStackView.snp.makeConstraints { make in
            make.width.equalTo(contentView.snp.width).multipliedBy(0.75)
            make.top.equalTo(streetLabel.snp.bottom)
            make.height.equalTo(50)
            make.leading.equalTo(contentView.snp.trailing)
        }
        
    }
    
    
}

