//
//  CustomAnnotationView.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 19.05.2023.
//

import UIKit
import MapKit
import RxSwift

final class CustomAnnotationView: MKAnnotationView {
    
    //MARK: - Creating UI Elements
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var leftCallOutView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        return view
    }()
    
    private lazy var leftCallOutButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        return button
    }()
    
    var leftCalloutAccessoryButtonTapped: Observable<Void> {
        return leftCallOutButton.rx.tap.asObservable()
    }
    
    //MARK: - Dispose Bag
    private (set) var disposeBag = DisposeBag()

    //MARK: - Init Methods
    init(annotation: MKAnnotation, categoryType: NetworkConstants, name: String) {
        super.init(annotation: annotation, reuseIdentifier: nil)
        configureAnnotationView()
        set(categoryType: categoryType, customAnnotation: annotation, name: name)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    private func configureAnnotationView() {
        setLeftCalloutView()
        bounds = CGRect(x: 0, y: 0, width: 44, height: 44)
        canShowCallout = true
        rightCalloutAccessoryView = leftCallOutView
        contentMode = .scaleAspectFit
        layer.cornerRadius = 22
        
    }
    func set(categoryType: NetworkConstants, customAnnotation: MKAnnotation, name: String) {
        annotation = customAnnotation
        backgroundColor =  .init(hex: MainHorizontalCollectionData.categoryType(categoryType).tintAndBackgroundColor).withAlphaComponent(0.4)
        setImage(categoryType: categoryType)
    }

    private func setLeftCalloutView() {
        leftCallOutView.addSubview(leftCallOutButton)
        
        leftCallOutButton.snp.makeConstraints { make in
            make.edges.equalTo(leftCallOutView)
        }
    }
    
    private func setImage(categoryType: NetworkConstants) {
        addSubview(imageView)
    
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(self).multipliedBy(0.7)
            make.center.equalTo(self.snp.center)
        }
        
        imageView.tintColor = .init(hex: MainHorizontalCollectionData.categoryType(categoryType).tintAndBackgroundColor)
        imageView.image = .init(named: MainCollectionData.categoryType(categoryType).image) ?? UIImage()
        
        
    }
    
    
    

}
