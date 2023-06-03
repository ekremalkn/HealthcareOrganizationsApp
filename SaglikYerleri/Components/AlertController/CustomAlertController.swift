//
//  CustomAlertController.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 19.05.2023.
//

import UIKit
import MapKit

final class CustomAlertController: UIAlertController {
        
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        
    }

    func showAlertForProfile(on viewController: UIViewController, button: ProfileButtonTableViewData, completion: @escaping () -> Void) {
        switch button {
        case .signIn:
            break
        case .signOut:
            let firstAction = UIAlertAction(title: "Çıkış Yap", style: .destructive) { _ in
                completion()
            }
            
            let secondAction = UIAlertAction(title: "Geri Dön", style: .default) { [weak self] _ in
                guard let self else { return }
                dismiss(animated: true)
            }
            
            addAction(firstAction)
            addAction(secondAction)
            
            viewController.present(self, animated: true)
        case .deleteAccount:
            let firstAction = UIAlertAction(title: "Hesabı Sil", style: .destructive) { _ in
                completion()
            }
            
            let secondAction = UIAlertAction(title: "Geri Dön", style: .default) { [weak self] _ in
                guard let self else { return }
                dismiss(animated: true)
            }
            
            addAction(firstAction)
            addAction(secondAction)
            
            viewController.present(self, animated: true)

        case .restorePurchases:
            break
        case .makePurchase:
            break
        }
    }
   
    
    //MARK: - Apple MapsAlert
    func showAlertForAppleMaps(on viewController: UIViewController, fromMapController annotation: MKAnnotation? = nil, fromRecentSearch coordinate: CLLocationCoordinate2D? = nil) {
        let firstAction = UIAlertAction(title: "Göster", style: .default) { [weak self] _ in
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
