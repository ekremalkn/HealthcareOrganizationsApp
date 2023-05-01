//
//  MapController.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 26.04.2023.
//

import UIKit

final class MapController: UIViewController {
    
    //MARK: - References
    let mapView = MapView()
    var mapViewModel: MapViewModel?
    
    //MARK: - Life Cycle Methods
    override func loadView() {
        super.loadView()
        view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    private func configureViewController() {
        self.navigationItem.searchController = mapView.searchController
    }
    
    
    
}
