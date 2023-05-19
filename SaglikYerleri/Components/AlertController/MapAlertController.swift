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

    func showAlert(on viewController: UIViewController, useWhenOkTapped annotation: MKAnnotation) {
        let firstAction = UIAlertAction(title: "Evet", style: .default) { [weak self] _ in
            // Open Apple Maps
            self?.openAppleMaps(with: annotation)
        }
        
        let secondAction = UIAlertAction(title: "Geri Dön", style: .cancel) //Cancel Style
        
        addAction(firstAction)
        addAction(secondAction)
        
        viewController.present(self, animated: true)
    }
    
    private func openAppleMaps(with annotation: MKAnnotation) {
        let coordinate = annotation.coordinate

        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.openInMaps()
    }
    
    
    


}
