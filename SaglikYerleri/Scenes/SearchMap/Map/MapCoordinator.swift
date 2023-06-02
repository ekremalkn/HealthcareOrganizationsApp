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
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var floatingPanel: FloatingPanelController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func startCoordinator() {
        
    }
    
    func childCoordinatorDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
            
        }
    }
    
    func startCoordinator(categoryType: NetworkConstants, cellType: CellType, customTopViewBC: UIColor) {
        let networkService: CityCountyService = NetworkService()
        let mapController = MapController(categoryType: categoryType, cellType: cellType, networkService: networkService, customTopViewBC: customTopViewBC)
        mapController.mapCoordinator = self
        navigationController.pushViewController(mapController, animated: true)
    }
    
    func mapClosed() {
        parentCoordinator?.childCoordinatorDidFinish(self)
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
