//
//  MapView.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 26.04.2023.
//

import UIKit
import MapKit

final class MapView: UIView {
    deinit {
        print("deinit mapVİEW")
    }
    //MARK: - Creating UI Elements
    lazy var backButton: UIBarButtonItem = {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .white
        return backButton
    }()
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        return mapView
    }()
    
    lazy var customTopView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var searchBarBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var alphaView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.2)
        view.isHidden = true
        return view
    }()
    
    lazy var loadingView: AnimationView = {
        let animationView = AnimationView(animationType: .loadingAnimation)
        animationView.isHidden = true
        return animationView
    }()
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layout Subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        customTopView.layer.cornerRadius = 12
        customTopView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner] // Only Top Left-Right
    }
    
    func configureCustomTopView(customTopViewBColor: UIColor) {
        customTopView.backgroundColor = customTopViewBColor.withAlphaComponent(0.8)
    }
    
    func configureAlphaView(hideAlphaView: Bool, completion: (() -> Void)? = nil) {
        if hideAlphaView {
            self.alphaView.isHidden = true
            completion?()
        } else {
            self.alphaView.isHidden = false
            completion?()
        }
    }
    
}

extension MapView: ViewProtocol {
    func configureView() {
        addSubview()
        setupConstraints()
    }
    
    func addSubview() {
        addSubview(mapView)
        mapView.addSubview(alphaView)
        mapView.addSubview(customTopView)
        mapView.addSubview(loadingView)
        
    }
    
    func setupConstraints() {
        mapViewConstraints()
        loadingViewConstraints()
        alphaViewConstraints()
        customTopViewConstraints()
    }
    
    private func mapViewConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    private func alphaViewConstraints() {
        alphaView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    private func loadingViewConstraints() {
        loadingView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.centerY)
            make.bottom.equalTo(self.snp.bottom)
            make.leading.trailing.equalTo(self)
        }
    }
    
    func customTopViewConstraints() {
        customTopView.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.leading.trailing.equalTo(self)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.top)
        }
    }
    
    
    
}
