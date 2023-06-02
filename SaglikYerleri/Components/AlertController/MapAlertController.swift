//
//  CustomAlertController.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 19.05.2023.
//

import UIKit
import MapKit

final class MapAlertController: UIAlertController {
        
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        
    }

    func showAlert(on viewController: UIViewController, fromMapController annotation: MKAnnotation? = nil, fromRecentSearch coordinate: CLLocationCoordinate2D? = nil) {
        let firstAction = UIAlertAction(title: "Evet", style: .default) { [weak self] _ in
            guard let self else { return }
            // Open Apple Maps
            if let coordinate {
                openAppleMapsFromRecentSearchController(coordinate: coordinate)
            } else {
                if let annotation {
                    openAppleMapsFromMapController(with: annotation)
                }

            }
        }
        
        let secondAction = UIAlertAction(title: "Geri Dön", style: .default) { [weak self] _ in
            guard let self else { return }
            dismiss(animated: true)
        } //Cancel Style
        
        addAction(firstAction)
        addAction(secondAction)
        
        viewController.present(self, animated: true)
    }
    
    private func openAppleMapsFromRecentSearchController(coordinate: CLLocationCoordinate2D) {
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.openInMaps()
    }
    
    private func openAppleMapsFromMapController(with annotation: MKAnnotation) {
        let coordinate = annotation.coordinate

        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.openInMaps()
    }
    
    
    


}
