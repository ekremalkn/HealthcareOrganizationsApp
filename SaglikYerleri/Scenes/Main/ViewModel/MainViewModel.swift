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
        MainHorizontalCollectionData.dutyPharmacies(image: UIImage(named: "duty")!, categoryTitle: "Nöbetçi Eczaneler", tintAndBackgroundColor: UIColor(hex: "FAAC7E")),
        MainHorizontalCollectionData.hospitals(image: UIImage(named: "hospital")!, categoryTitle: "Tüm Hastaneler", tintAndBackgroundColor: UIColor(hex: "5D9AFF")),
        MainHorizontalCollectionData.allPharmacies(image: UIImage(named: "pills")!, categoryTitle: "Tüm Eczaneler", tintAndBackgroundColor: UIColor(hex: "F98B8B")),
        MainHorizontalCollectionData.dentalCenters(image: UIImage(named: "dental")!, categoryTitle: "Diş Sağlığı Merkezleri", tintAndBackgroundColor: UIColor(hex: "F87EB7")),
        MainHorizontalCollectionData.healthCenters(image: UIImage(systemName: "bandage")!, categoryTitle: "Sağlık Ocakları", tintAndBackgroundColor: UIColor(hex: "3CB5B7"))
    ])
    
    let mainCollectionData = Observable.just([
        MainCollectionData.hospitals(itle: "Hastanaler", backgroundColor: UIColor(hex: "5D9AFF")),
        MainCollectionData.healthCenters(title: "Sağlık Ocakları", backgroundColor: UIColor(hex: "3CB5B7")),
        MainCollectionData.dentalCenters(title: "Diş Klinikleri", backgroundColor: UIColor(hex: "F87EB7")),
        MainCollectionData.allPharmacies(itle: "Eczaneler", backgroundColor: UIColor(hex: "F98B8B")),
        MainCollectionData.dutyPharmacies(title: "Nöbetçi Eczaneler", backgroundColor: UIColor(hex: "FAAC7E")),
        MainCollectionData.medicalLaboratories(title: "Tıbbi Laboratuvarlar", backgroundColor: UIColor(hex: "7879F1")),
        MainCollectionData.radiologyCenters(itle: "Radyoloji Merkezleri", backgroundColor: UIColor(hex: "5D9AFF")),
        MainCollectionData.animalHospitals(itle: "Hayvan Hastanaleri", backgroundColor: UIColor(hex: "FBC134")),
        MainCollectionData.psychologistCenters(itle: "Psikologlar", backgroundColor: UIColor(hex: "65D6B8")),
        MainCollectionData.gynecologyCenters(itle: "Jinekologlar", backgroundColor: UIColor(hex: "F392C3"))
    ])
}
