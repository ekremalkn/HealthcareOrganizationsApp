//
//  MainModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 22.04.2023.
//

import UIKit



enum MainCollectionData {
    case categoryType(NetworkConstants)
    
    var selectedCategoryType: NetworkConstants {
        switch self {
        case .categoryType(let networkConstants):
            switch networkConstants {
            case .pharmacy:
                return networkConstants
            case .dutyPharmacy:
                return networkConstants
            case .healthCenters:
                return networkConstants
            case .dentalCenters:
                return networkConstants
            case .privateDentalCenters:
                return networkConstants
            case .medicalLaboratories:
                return networkConstants
            case .radiologyCenters:
                return networkConstants
            case .spaCenters:
                return networkConstants
            case .psychologistCenters:
                return networkConstants
            case .gynecologyCenters:
                return networkConstants
            case .opticCenters:
                return networkConstants
            case .animalHospitals:
                return networkConstants
            case .dialysisCenters:
                return networkConstants
            case .emergencyCenters:
                return networkConstants
            case .medicalShopCenters:
                return networkConstants
            case .physiotheraphyCenters:
                return networkConstants
            case .hospitals:
                return networkConstants
            }
        }
    }
}

extension MainCollectionData {
    var categoryTitle: String {
        switch self {
        case .categoryType(let networkConstants):
            switch networkConstants {
            case .pharmacy:
                return "Tüm Eczaneler"
            case .dutyPharmacy:
                return "Nöbetçi Eczaneler"
            case .healthCenters:
                return "Sağlık Ocakları"
            case .hospitals:
                return "Hastaneler"
            case .dentalCenters:
                return "Diş Klinikleri"
            case .privateDentalCenters:
                return "Ozel Diş Klinikleri"
            case .medicalLaboratories:
                return "Tıbbi Laboratuvarlar"
            case .radiologyCenters:
                return "Radiyoloji Merkezleri"
            case .spaCenters:
                return "Spa Merkezleri"
            case .psychologistCenters:
                return "Psikologlar"
            case .gynecologyCenters:
                return "Jinekologlar"
            case .opticCenters:
                return "Optik Merkezleri"
            case .animalHospitals:
                return "Hayvan Hastaneleri"
            case .dialysisCenters:
                return "Diyaliz Merkzleri"
            case .emergencyCenters:
                return "Acil Servisler"
            case .medicalShopCenters:
                return "Medikal Alışveriş Merkezleri"
            case .physiotheraphyCenters:
                return "Fizik Tedavi Merkezleri"
            }
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .categoryType(let networkConstants):
            switch networkConstants {
            case .pharmacy:
                return UIColor(hex: "F98B8B")
            case .dutyPharmacy:
                return UIColor(hex: "FAAC7E")
            case .healthCenters:
                return UIColor(hex: "3CB5B7")
            case .hospitals:
                return UIColor(hex: "5D9AFF")
            case .dentalCenters:
                return UIColor(hex: "F87EB7")
            case .privateDentalCenters:
                return UIColor(hex: "00AEDB")
            case .medicalLaboratories:
                return UIColor(hex: "7879F1")
            case .radiologyCenters:
                return UIColor(hex: "5D9AFF")
            case .spaCenters:
                return UIColor(hex: "C5b9CD")
            case .psychologistCenters:
                return UIColor(hex: "65D6B8")
            case .gynecologyCenters:
                return UIColor(hex: "F392C3")
            case .opticCenters:
                return UIColor(hex: "FFC425")
            case .animalHospitals:
                return UIColor(hex: "FBC134")
            case .dialysisCenters:
                return UIColor(hex: "B4C468")
            case .emergencyCenters:
                return UIColor(hex: "D11141")
            case .medicalShopCenters:
                return UIColor(hex: "92A8D1")
            case .physiotheraphyCenters:
                return UIColor(hex: "ABB1CF")
            }
        }
    }
    
    var image: UIImage {
        switch self {
        case .categoryType(let networkConstants):
            switch networkConstants {
            case .dutyPharmacy:
                return UIImage(named: "dutyPharmacy2") ?? UIImage()
            case .pharmacy:
                return UIImage(named: "pharmacy") ?? UIImage()
            case .healthCenters:
                return UIImage(systemName: "bandage") ?? UIImage()
            case .hospitals:
                return UIImage(named: "hospital") ?? UIImage()
            case .dentalCenters:
                return UIImage(named: "dentalCenter") ?? UIImage()
            case .privateDentalCenters:
                return UIImage(named: "dentalCenter") ?? UIImage()
            case .medicalLaboratories:
                return UIImage(named: "medicalLaboratory") ?? UIImage()
            case .radiologyCenters:
                return UIImage(named: "radiologyCenter") ?? UIImage()
            case .spaCenters:
                return UIImage(named: "spaCenter") ?? UIImage()
            case .psychologistCenters:
                return UIImage(named: "psychologyCenter") ?? UIImage()
            case .gynecologyCenters:
                return UIImage(named: "gynecologyCenter") ?? UIImage()
            case .opticCenters:
                return UIImage(named: "opticCenter") ?? UIImage()
            case .animalHospitals:
                return UIImage(named: "animalHospital") ?? UIImage()
            case .dialysisCenters:
                return UIImage(named: "dialysisCenter") ?? UIImage()
            case .emergencyCenters:
                return UIImage(named: "emergencyCenter") ?? UIImage()
            case .medicalShopCenters:
                return UIImage(named: "medicalShopCenter") ?? UIImage()
            case .physiotheraphyCenters:
                return UIImage(named: "physiotherapyCenter") ?? UIImage()
                
            }
        }
    }
}
