//
//  MainHorizontalCollectionModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 6.05.2023.
//

import UIKit

enum MainHorizontalCollectionData {
    case categoryType(NetworkConstants)
    
    var selectedCategoryType: NetworkConstants {
        switch self {
        case .categoryType(let networkConstants):
            switch networkConstants {
            case .pharmacy:
                return networkConstants
            case .healthCenters:
                return networkConstants
            case .hospitals:
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
            case .dutyPharmacy:
                return networkConstants
            }
        }
    }
    
}

extension MainHorizontalCollectionData {
    var image: UIImage {
        switch self {
        case .categoryType(let networkConstants):
            switch networkConstants {
            case .dutyPharmacy:
                return UIImage(named: "duty")!
            case .pharmacy:
                break
            case .healthCenters:
                return UIImage(systemName: "bandage")!
            case .hospitals:
                return UIImage(named: "hospital")!
            case .dentalCenters:
                return UIImage(named: "dental")!
            case .privateDentalCenters:
                break
            case .medicalLaboratories:
                break
            case .radiologyCenters:
                break
            case .spaCenters:
                break
            case .psychologistCenters:
                break
            case .gynecologyCenters:
                break
            case .opticCenters:
                break
            case .animalHospitals:
                break
            case .dialysisCenters:
                break
            case .emergencyCenters:
                break
            case .medicalShopCenters:
                break
            case .physiotheraphyCenters:
                break
                
            }
        }
        return UIImage()
    }
    
    var categoryTitle: String {
        switch self {
        case .categoryType(let networkConstants):
            switch networkConstants {
            case .dutyPharmacy:
                return "Nöbetçi Eczaneler"
            case .pharmacy:
                break
            case .healthCenters:
                return "Sağlık Ocakları"
            case .hospitals:
                return "Tüm Hastaneler"
            case .dentalCenters:
                return "Diş Sağlığı Merkezleri"
            case .privateDentalCenters:
                break
            case .medicalLaboratories:
                break
            case .radiologyCenters:
                break
            case .spaCenters:
                break
            case .psychologistCenters:
                break
            case .gynecologyCenters:
                break
            case .opticCenters:
                break
            case .animalHospitals:
                break
            case .dialysisCenters:
                break
            case .emergencyCenters:
                break
            case .medicalShopCenters:
                break
            case .physiotheraphyCenters:
                break
                
            }
        }
        return ""
    }
    
    var tintAndBackgroundColor: UIColor {
        switch self {
        case .categoryType(let networkConstants):
            switch networkConstants {
            case .dutyPharmacy:
                return UIColor(hex: "FAAC7E")
            case .pharmacy:
                break
            case .healthCenters:
                return UIColor(hex: "3CB5B7")
            case .hospitals:
                return UIColor(hex: "5D9AFF")
            case .dentalCenters:
                return UIColor(hex: "F87EB7")
            case .privateDentalCenters:
                break
            case .medicalLaboratories:
                break
            case .radiologyCenters:
                break
            case .spaCenters:
                break
            case .psychologistCenters:
                break
            case .gynecologyCenters:
                break
            case .opticCenters:
                break
            case .animalHospitals:
                break
            case .dialysisCenters:
                break
            case .emergencyCenters:
                break
            case .medicalShopCenters:
                break
            case .physiotheraphyCenters:
                break
                
            }
        }
        return UIColor()
    }
}

