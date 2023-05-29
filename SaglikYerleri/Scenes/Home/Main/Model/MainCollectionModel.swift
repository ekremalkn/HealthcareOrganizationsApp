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
    
    var cellTypeAccorindToCategory: CellType {
        switch self {
        case .categoryType(let networkConstants):
            switch networkConstants {
            case .pharmacy:
                return .pharmacyCell
            case .healthCenters:
                return .sharedCell1
            case .hospitals:
                return .sharedCell1
            case .dentalCenters:
                return .sharedCell2
            case .privateDentalCenters:
                return .sharedCell2
            case .medicalLaboratories:
                return .sharedCell1
            case .radiologyCenters:
                return .sharedCell1
            case .spaCenters:
                return .sharedCell2
            case .psychologistCenters:
                return .sharedCell2
            case .gynecologyCenters:
                return .sharedCell2
            case .opticCenters:
                return .sharedCell2
            case .animalHospitals:
                return .sharedCell2
            case .dialysisCenters:
                return .sharedCell2
            case .emergencyCenters:
                return .sharedCell2
            case .medicalShopCenters:
                return .sharedCell2
            case .physiotheraphyCenters:
                return .sharedCell2
            case .dutyPharmacy:
                return .pharmacyCell
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
                return "Özel Diş Klinikleri"
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
    
    var backgroundColor: String {
        switch self {
        case .categoryType(let networkConstants):
            switch networkConstants {
            case .pharmacy:
                return "FF5C5C"
            case .dutyPharmacy:
                return "FF9556"
            case .healthCenters:
                return "56CBCC"
            case .hospitals:
                return "498EFF"
            case .dentalCenters:
                return "FF60AA"
            case .privateDentalCenters:
                return "0098BF"
            case .medicalLaboratories:
                return "5657EF"
            case .radiologyCenters:
                return "4B75BA"
            case .spaCenters:
                return "BD97D7"
            case .psychologistCenters:
                return "44DEB5"
            case .gynecologyCenters:
                return "F269CC"
            case .opticCenters:
                return "F5CB58"
            case .animalHospitals:
                return "FF8900"
            case .dialysisCenters:
                return "D3FF00"
            case .emergencyCenters:
                return "D11141"
            case .medicalShopCenters:
                return "477AD9"
            case .physiotheraphyCenters:
                return "5D52A5"
            }
        }
    }
    
    var secondBackgroundColor: String {
        switch self {
        case .categoryType(let networkConstants):
            switch networkConstants {
            case .pharmacy:
                return "FF1212"
            case .dutyPharmacy:
                return "FC7221"
            case .healthCenters:
                return "00C1C3"
            case .hospitals:
                return "0061FF"
            case .dentalCenters:
                return "FF0077"
            case .privateDentalCenters:
                return "005B73"
            case .medicalLaboratories:
                return "3E40EA"
            case .radiologyCenters:
                return "0046BA"
            case .spaCenters:
                return "891AD6"
            case .psychologistCenters:
                return "00B86B"
            case .gynecologyCenters:
                return "FF00B8"
            case .opticCenters:
                return "FFA800"
            case .animalHospitals:
                return "D6790D"
            case .dialysisCenters:
                return "91AF00"
            case .emergencyCenters:
                return "7A001F"
            case .medicalShopCenters:
                return "0059FF"
            case .physiotheraphyCenters:
                return "1700AB"
            }
        }
    }
    
    var image: String {
        switch self {
        case .categoryType(let networkConstants):
            switch networkConstants {
            case .dutyPharmacy:
                return "dutyPharmacy2"
            case .pharmacy:
                return "pharmacy"
            case .healthCenters:
                return "bandage"
            case .hospitals:
                return "hospital"
            case .dentalCenters:
                return "dentalCenter"
            case .privateDentalCenters:
                return "dentalCenter"
            case .medicalLaboratories:
                return "medicalLaboratory"
            case .radiologyCenters:
                return "radiologyCenter"
            case .spaCenters:
                return "spaCenter"
            case .psychologistCenters:
                return "psychologyCenter"
            case .gynecologyCenters:
                return "gynecologyCenter"
            case .opticCenters:
                return "opticCenter"
            case .animalHospitals:
                return "animalHospital"
            case .dialysisCenters:
                return "dialysisCenter"
            case .emergencyCenters:
                return "emergencyCenter"
            case .medicalShopCenters:
                return "medicalShopCenter"
            case .physiotheraphyCenters:
                return "physiotherapyCenter"
                
            }
        }
    }
}
