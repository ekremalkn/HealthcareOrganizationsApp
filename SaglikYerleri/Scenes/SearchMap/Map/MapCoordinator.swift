//
//  MapCoordinator.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 5.05.2023.
//

import UIKit
import FloatingPanel

final class MapCoordinator: MapCoordinatorProtocol {
    deinit {
        print("deinit MAPCOORDINATOR")
    }
    var childCoordinator: [Coordinator] = []
    
    var navigationController = UINavigationController()
    
    var floatingPanel: FloatingPanelController?
    
    func startCoordinator() {
        
    }
    
    func openFloatingController(categoryType: NetworkConstants, cellType: CellType, mapController: MapController, citySlug: String, countySlug: String, cityName: String, countyName: String, parentVC: UIViewController) {
        
        if let floatingPanel {
            let networkService: OrganizationsService = NetworkService()
            let surfaceView = floatingPanel.surfaceView
            surfaceView?.backgroundColor = .clear
            let floatingController = FloatingController(categoryType: categoryType, cellType: cellType, mapController: mapController, networkService: networkService, citySlug: citySlug, countySlug: countySlug, cityName: cityName, countyName: countyName)
            floatingPanel.set(contentViewController: floatingController)
            floatingPanel.move(to: .half, animated: true)
        } else {
            let networkService: OrganizationsService = NetworkService()
            self.floatingPanel = FloatingPanelController()
            let surfaceView = floatingPanel?.surfaceView
            surfaceView?.backgroundColor = .clear
            let floatingController = FloatingController(categoryType: categoryType, cellType: cellType, mapController: mapController, networkService: networkService, citySlug: citySlug, countySlug: countySlug, cityName: cityName, countyName: countyName)
            floatingPanel?.set(contentViewController: floatingController)
            floatingPanel?.addPanel(toParent: parentVC)
            floatingPanel?.move(to: .half, animated: true)
        }
        
    }
    
    func moveFloatingPanelToTip() {
        guard let floatingPanel else { return }
        floatingPanel.move(to: .tip, animated: true)
    }
}
