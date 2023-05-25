//
//  MainHorizontalCollectionModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 6.05.2023.
//

import UIKit

public enum MainHorizontalCollectionData {
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
                return UIImage(named: "dutyPharmacy") ?? UIImage()
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
                return "Radyoloji Merkezleri"
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
    
    var tintAndBackgroundColor: UIColor {
        switch self {
        case .categoryType(let networkConstants):
            switch networkConstants {
            case .pharmacy:
                return UIColor(hex: "FF5C5C")
            case .dutyPharmacy:
                return UIColor(hex: "FF9556")
            case .healthCenters:
                return UIColor(hex: "32BDBF")
            case .hospitals:
                return UIColor(hex: "498EFF")
            case .dentalCenters:
                return UIColor(hex: "FF60AA")
            case .privateDentalCenters:
                return UIColor(hex: "0098BF")
            case .medicalLaboratories:
                return UIColor(hex: "696AE5")
            case .radiologyCenters:
                return UIColor(hex: "4B75BA")
            case .spaCenters:
                return UIColor(hex: "BD97D7")
            case .psychologistCenters:
                return UIColor(hex: "44DEB5")
            case .gynecologyCenters:
                return UIColor(hex: "F63C9A")
            case .opticCenters:
                return UIColor(hex: "FFBC08")
            case .animalHospitals:
                return UIColor(hex: "D6790D")
            case .dialysisCenters:
                return UIColor(hex: "91AF00")
            case .emergencyCenters:
                return UIColor(hex: "D11141")
            case .medicalShopCenters:
                return UIColor(hex: "2966D7")
            case .physiotheraphyCenters:
                return UIColor(hex: "5D52A5")
            }
        }
    }
}

