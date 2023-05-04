//
//  MapView.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 26.04.2023.
//

import UIKit
import MapKit

final class MapView: UIView {
    
    //MARK: - Creating UI Elements
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        return mapView
    }()
    
    private lazy var alphaView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.2)
        view.isHidden = true
        return view
    }()
    
    lazy var loadingView = LoadingView()
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func congfigureAlphaView(hideAlphaView: Bool) {
        if hideAlphaView {
            self.alphaView.isHidden = true
        } else {
            self.alphaView.isHidden = false
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
        mapView.addSubview(loadingView)
        mapView.addSubview(alphaView)
    }
    
    func setupConstraints() {
        mapViewConstraints()
        loadingViewConstraints()
        alphaViewConstraints()
    }
    
    private func mapViewConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    private func loadingViewConstraints() {
        loadingView.snp.makeConstraints { make in
            make.center.equalTo(mapView.snp.center)
            make.height.width.equalTo(64)
        }
    }
    
    private func alphaViewConstraints() {
        alphaView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    
}
