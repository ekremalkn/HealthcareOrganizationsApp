//
//  MainModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 22.04.2023.
//

import UIKit



enum MainCollectionData {
    
    case dutyPharmacies(title: String, backgroundColor: UIColor, type: NetworkConstants)
    case allPharmacies(title: String, backgroundColor: UIColor, type: NetworkConstants)
    case healthCenters(title: String, backgroundColor: UIColor, type: NetworkConstants)
    case hospitals(title: String, backgroundColor: UIColor, type: NetworkConstants)
    case dentalCenters(title: String, backgroundColor: UIColor, type: NetworkConstants)
    case privateDentalCenters(title: String, backgroundColor: UIColor, type: NetworkConstants)
    case medicalLaboratories(title: String, backgroundColor: UIColor, type: NetworkConstants)
    case radiologyCenters(title: String, backgroundColor: UIColor, type: NetworkConstants)
    case spaCenters(title: String, backgroundColor: UIColor, type: NetworkConstants)
    case psychologistCenters(title: String, backgroundColor: UIColor, type: NetworkConstants)
    case gynecologyCenters(title: String, backgroundColor: UIColor, type: NetworkConstants)
    case physiotheraphyCenters(title: String, backgroundColor: UIColor, type: NetworkConstants)
    case opticCenters(title: String, backgroundColor: UIColor, type: NetworkConstants)
    case animalHospitals(title: String, backgroundColor: UIColor, type: NetworkConstants)
    case dialysisCenters(title: String, backgroundColor: UIColor, type: NetworkConstants)
    case emergencyCenters(title: String, backgroundColor: UIColor, type: NetworkConstants)
    case medicalShopCenters(title: String, backgroundColor: UIColor, type: NetworkConstants)
}

extension MainCollectionData {
    var categoryTitle: String {
        switch self {
        case .dutyPharmacies(let title, _, _):
            return title
        case .allPharmacies(let title, _, _):
            return title
        case .healthCenters(let title, _, _):
            return title
        case .hospitals(let title, _, _):
            return title
        case .dentalCenters(let title, _, _):
            return title
        case .medicalLaboratories(let title, _, _):
            return title
        case .radiologyCenters(let title, _, _):
            return title
        case .spaCenters(let title, _, _):
            return title
        case .psychologistCenters(let title, _, _):
            return title
        case .gynecologyCenters(let title, _, _):
            return title
        case .physiotheraphyCenters(let title, _, _):
            return title
        case .opticCenters(let title, _, _):
            return title
        case .animalHospitals(let title, _, _):
            return title
        case .dialysisCenters(let title, _, _):
            return title
        case .emergencyCenters(let title, _, _):
            return title
        case .privateDentalCenters(title: let title, _, _):
            return title
        case .medicalShopCenters(title: let title, _, _):
            return title
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .dutyPharmacies(_, let backgroundColor, _):
            return backgroundColor
        case .allPharmacies(_, let backgroundColor, _):
            return backgroundColor
        case .healthCenters(_, let backgroundColor, _):
            return backgroundColor
        case .hospitals(_, let backgroundColor, _):
            return backgroundColor
        case .dentalCenters(_, let backgroundColor, _):
            return backgroundColor
        case .medicalLaboratories(_, let backgroundColor, _):
            return backgroundColor
        case .radiologyCenters(_, let backgroundColor, _):
            return backgroundColor
        case .spaCenters(_, let backgroundColor, _):
            return backgroundColor
        case .psychologistCenters(_, let backgroundColor, _):
            return backgroundColor
        case .gynecologyCenters(_, let backgroundColor, _):
            return backgroundColor
        case .physiotheraphyCenters(_, let backgroundColor, _):
            return backgroundColor
        case .opticCenters(_, let backgroundColor, _):
            return backgroundColor
        case .animalHospitals(_, let backgroundColor, _):
            return backgroundColor
        case .dialysisCenters(_, let backgroundColor, _):
            return backgroundColor
        case .emergencyCenters(_, let backgroundColor, _):
            return backgroundColor
        case .privateDentalCenters(_, let backgroundColor, _):
            return backgroundColor
        case .medicalShopCenters(_, let backgroundColor, _):
            return backgroundColor
        }
    }
    
    var categoryType: NetworkConstants {
        switch self {
        case .dutyPharmacies(_,  _, let type):
            return type
        case .allPharmacies(_, _, let type):
            return type
        case .healthCenters(_, _, let type):
            return type
        case .hospitals(_, _, let type):
            return type
        case .dentalCenters(_, _, let type):
            return type
        case .medicalLaboratories(_, _, let type):
            return type
        case .radiologyCenters(_, _,  let type):
            return type
        case .spaCenters(_, _, let type):
            return type
        case .psychologistCenters(_, _, let type):
            return type
        case .gynecologyCenters(_, _, let type):
            return type
        case .physiotheraphyCenters(_, _, let type):
            return type
        case .opticCenters(_, _, let type):
            return type
        case .animalHospitals(_, _, let type):
            return type
        case .dialysisCenters(_, _, let type):
            return type
        case .emergencyCenters(_, _, let type):
            return type
        case .privateDentalCenters(_,  _, type: let type):
            return type
        case .medicalShopCenters(_,  _, type: let type):
            return type
        }
    }
}
