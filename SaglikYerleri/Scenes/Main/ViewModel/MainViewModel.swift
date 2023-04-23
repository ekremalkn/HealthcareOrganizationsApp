//
//  MainViewModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 22.04.2023.
//

import UIKit
import RxSwift

final class MainViewModel {
    
    let horizontalCollectionData = Observable.just([
        MainHorizontalCollectionData.dutyPharmacies(image: UIImage(systemName: "cross")!, categoryTitle: "Nöbetçi Eczaneler"),
        MainHorizontalCollectionData.hospitals(image: UIImage(systemName: "cross")!, categoryTitle: "Tüm Hastaneler"),
        MainHorizontalCollectionData.allPharmacies(image: UIImage(systemName: "cross")!, categoryTitle: "Tüm Eczaneler"),
        MainHorizontalCollectionData.dentalCenters(image: UIImage(systemName: "cross")!, categoryTitle: "Diş Sağlığı Merkezleri"),
        MainHorizontalCollectionData.healthCenters(image: UIImage(systemName: "cross")!, categoryTitle: "Sağlık Ocakları")
    ])
    
    let verticalCollectionData = Observable.just([
        MainVerticalCollectionData.hospitals(itle: "Hastanaler", backgroundColor: UIColor(hex: "5D9AFF")),
        MainVerticalCollectionData.healthCenters(title: "Sağlık Ocakları", backgroundColor: UIColor(hex: "3CB5B7")),
        MainVerticalCollectionData.dentalCenters(title: "Diş Klinikleri", backgroundColor: UIColor(hex: "F87EB7")),
        MainVerticalCollectionData.allPharmacies(itle: "Eczaneler", backgroundColor: UIColor(hex: "F98B8B")),
        MainVerticalCollectionData.dutyPharmacies(title: "Nöbetçi Eczaneler", backgroundColor: UIColor(hex: "FAAC7E")),
        MainVerticalCollectionData.medicalLaboratories(title: "Tıbbi Laboratuvarlar", backgroundColor: UIColor(hex: "7879F1")),
        MainVerticalCollectionData.radiologyCenters(itle: "Radyoloji Merkezleri", backgroundColor: UIColor(hex: "5D9AFF")),
        MainVerticalCollectionData.animalHospitals(itle: "Hayvan Hastanaleri", backgroundColor: UIColor(hex: "FBC134")),
        MainVerticalCollectionData.psychologistCenters(itle: "Psikologlar", backgroundColor: UIColor(hex: "65D6B8")),
        MainVerticalCollectionData.gynecologyCenters(itle: "Jinekologlar", backgroundColor: UIColor(hex: "F392C3"))
    ])
}
