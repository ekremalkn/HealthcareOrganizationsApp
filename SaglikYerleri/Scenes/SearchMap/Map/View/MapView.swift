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
    
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MapView: ViewProtocol {
    func configureView() {
        addSubview()
        setupConstraints()
    }
    
    func addSubview() {
        addSubview(mapView)
    }
    
    func setupConstraints() {
        mapViewConstraints()
    }
    
    private func mapViewConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    
}
