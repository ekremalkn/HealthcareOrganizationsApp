//
//  MapCoordinatorProtocol.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 6.05.2023.
//

import UIKit

protocol MapCoordinatorProtocol: Coordinator {
    func openFloatingController(categoryType: NetworkConstants, mapController: MapController, citySlug: String, countySlug: String, cityName: String, countyName: String, parentVC: UIViewController)
    func moveFloatingPanelToTip()
}
