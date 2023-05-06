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
        MainHorizontalCollectionData.dutyPharmacies(image: UIImage(named: "duty")!, categoryTitle: "Nöbetçi Eczaneler", tintAndBackgroundColor: UIColor(hex: "FAAC7E"), type: .pharmacy),
        MainHorizontalCollectionData.hospitals(image: UIImage(named: "hospital")!, categoryTitle: "Tüm Hastaneler", tintAndBackgroundColor: UIColor(hex: "5D9AFF"), type: .hospitals),
        MainHorizontalCollectionData.allPharmacies(image: UIImage(named: "pills")!, categoryTitle: "Tüm Eczaneler", tintAndBackgroundColor: UIColor(hex: "F98B8B"), type: .pharmacy),
        MainHorizontalCollectionData.dentalCenters(image: UIImage(named: "dental")!, categoryTitle: "Diş Sağlığı Merkezleri", tintAndBackgroundColor: UIColor(hex: "F87EB7"), type: .dentalCenters),
        MainHorizontalCollectionData.healthCenters(image: UIImage(systemName: "bandage")!, categoryTitle: "Sağlık Ocakları", tintAndBackgroundColor: UIColor(hex: "3CB5B7"), type: .healthCenters)
    ])
    
    let mainCollectionData = Observable.just([
        MainCollectionData.hospitals(title: "Hastanaler", backgroundColor: UIColor(hex: "5D9AFF"), type: .hospitals),
        MainCollectionData.healthCenters(title: "Sağlık Ocakları", backgroundColor: UIColor(hex: "3CB5B7"), type: .healthCenters),
        MainCollectionData.dentalCenters(title: "Diş Klinikleri", backgroundColor: UIColor(hex: "F87EB7"), type: .dentalCenters),
        MainCollectionData.allPharmacies(title: "Eczaneler", backgroundColor: UIColor(hex: "F98B8B"), type: .pharmacy),
        MainCollectionData.dutyPharmacies(title: "Nöbetçi Eczaneler", backgroundColor: UIColor(hex: "FAAC7E"), type: .pharmacy),
        MainCollectionData.dialysisCenters(title: "Diyaliz Merkezleri", backgroundColor: UIColor(hex: "B4C468"), type: .dialysisCenters),
        MainCollectionData.physiotheraphyCenters(title: "Fizik Tedavi Merkezleri", backgroundColor: UIColor(hex: "ABB1CF"), type: .physiotheraphyCenters),
        MainCollectionData.privateDentalCenters(title: "Ozel Diş Klinikleri", backgroundColor: UIColor(hex: "00AEDB"), type: .privateDentalCenters),
        MainCollectionData.opticCenters(title: "Optik Merkezleri", backgroundColor: UIColor(hex: "FFC425"), type: .opticCenters),
        MainCollectionData.emergencyCenters(title: "Acil Servisler", backgroundColor: UIColor(hex: "D11141"), type: .emergencyCenters),
        MainCollectionData.medicalShopCenters(title: "Medikal Alışveriş Merkezleri", backgroundColor: UIColor(hex: "92A8D1"), type: .medicalShopCenters),
        MainCollectionData.spaCenters(title: "Spa Merkezleri", backgroundColor: UIColor(hex: "C5b9CD"), type: .spaCenters),
        MainCollectionData.medicalLaboratories(title: "Tıbbi Laboratuvarlar", backgroundColor: UIColor(hex: "7879F1"), type: .medicalLaboratories),
        MainCollectionData.radiologyCenters(title: "Radyoloji Merkezleri", backgroundColor: UIColor(hex: "5D9AFF"), type: .radiologyCenters),
        MainCollectionData.animalHospitals(title: "Hayvan Hastanaleri", backgroundColor: UIColor(hex: "FBC134"), type: .animalHospitals),
        MainCollectionData.psychologistCenters(title: "Psikologlar", backgroundColor: UIColor(hex: "65D6B8"), type: .psychologistCenters),
        MainCollectionData.gynecologyCenters(title: "Jinekologlar", backgroundColor: UIColor(hex: "F392C3"), type: .gynecologyCenters)
    ])
}
