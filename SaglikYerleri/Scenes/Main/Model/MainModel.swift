//
//  MainModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 22.04.2023.
//

import UIKit

indirect enum MainHorizontalCollectionData {
    case dutyPharmacies(image: UIImage, categoryTitle: String, tintAndBackgroundColor: UIColor, type: NetworkConstants)
    case allPharmacies(image: UIImage, categoryTitle: String, tintAndBackgroundColor: UIColor, type: NetworkConstants)
    case healthCenters(image: UIImage, categoryTitle: String, tintAndBackgroundColor: UIColor, type: NetworkConstants)
    case hospitals(image: UIImage, categoryTitle: String, tintAndBackgroundColor: UIColor, type: NetworkConstants)
    case dentalCenters(image: UIImage, categoryTitle: String, tintAndBackgroundColor: UIColor, type: NetworkConstants)
}

extension MainHorizontalCollectionData {
    var image: UIImage {
        switch self {
        case .dutyPharmacies(image: let image, categoryTitle: _, tintAndBackgroundColor:_, type: _):
            return image
        case .allPharmacies(image: let image, categoryTitle: _, tintAndBackgroundColor:_, type: _):
            return image
        case .healthCenters(image: let image, categoryTitle: _, tintAndBackgroundColor:_, type: _):
            return image
        case .hospitals(image: let image, categoryTitle: _, tintAndBackgroundColor:_, type: _):
            return image
        case .dentalCenters(image: let image, categoryTitle: _, tintAndBackgroundColor:_, type: _):
            return image
        }
    }
    
    var categoryTitle: String {
        switch self {
        case .dutyPharmacies( _, let categoryTitle, tintAndBackgroundColor:_, type: _):
            return categoryTitle
        case .allPharmacies( _, let categoryTitle, tintAndBackgroundColor:_, type: _):
            return categoryTitle
        case .healthCenters( _, let categoryTitle, tintAndBackgroundColor:_, type: _):
            return categoryTitle
        case .hospitals( _, let categoryTitle, tintAndBackgroundColor:_, type: _):
            return categoryTitle
        case .dentalCenters( _, let categoryTitle, tintAndBackgroundColor:_, type: _):
            return categoryTitle
        }
    }
    
    var tintAndBackgroundColor: UIColor {
        switch self {
        case .dutyPharmacies(_, _, let tintAndBackgroundColor, type: _):
            return tintAndBackgroundColor
        case .allPharmacies(_, _, let tintAndBackgroundColor, type: _):
            return tintAndBackgroundColor
        case .healthCenters(_, _, let tintAndBackgroundColor, type: _):
            return tintAndBackgroundColor
        case .hospitals(_, _, let tintAndBackgroundColor, type: _):
            return tintAndBackgroundColor
        case .dentalCenters(_, _, let tintAndBackgroundColor, type: _):
            return tintAndBackgroundColor
        }
    }
    
    var categoryType: NetworkConstants {
        switch self {
        case .dutyPharmacies(_, _, _, let type):
            return type
        case .allPharmacies(_, _, _, let type):
            return type
        case .healthCenters(_, _, _, let type):
            return type
        case .hospitals(_, _, _, let type):
            return type
        case .dentalCenters(_, _, _, let type):
            return type
        }
    }
    
}

enum MainCollectionData {

    case dutyPharmacies(title: String, backgroundColor: UIColor, type: NetworkConstants)
    case allPharmacies(title: String, backgroundColor: UIColor, type: NetworkConstants)
    case healthCenters(title: String, backgroundColor: UIColor, type: NetworkConstants)
    case hospitals(title: String, backgroundColor: UIColor, type: NetworkConstants)
    case dentalCenters(title: String, backgroundColor: UIColor, type: NetworkConstants)
    case medicalLaboratories(title: String, backgroundColor: UIColor, type: NetworkConstants)
    case radiologyCenters(title: String, backgroundColor: UIColor, type: NetworkConstants)
    case spaCenters(title: String, backgroundColor: UIColor, type: NetworkConstants)
    case psychologistCenters(title: String, backgroundColor: UIColor, type: NetworkConstants)
    case gynecologyCenters(title: String, backgroundColor: UIColor, type: NetworkConstants)
    case physicalTherapyCenters(title: String, backgroundColor: UIColor, type: NetworkConstants)
    case opticalCenters(title: String, backgroundColor: UIColor, type: NetworkConstants)
    case animalHospitals(title: String, backgroundColor: UIColor, type: NetworkConstants)
    case dialysisCenters(title: String, backgroundColor: UIColor, type: NetworkConstants)
    case emergencyCenters(title: String, backgroundColor: UIColor, type: NetworkConstants)
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
        case .physicalTherapyCenters(let title, _, _):
            return title
        case .opticalCenters(let title, _, _):
            return title
        case .animalHospitals(let title, _, _):
            return title
        case .dialysisCenters(let title, _, _):
            return title
        case .emergencyCenters(let title, _, _):
            return title
        }
    }
    
    var bacgroundColor: UIColor {
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
        case .physicalTherapyCenters(_, let backgroundColor, _):
            return backgroundColor
        case .opticalCenters(_, let backgroundColor, _):
            return backgroundColor
        case .animalHospitals(_, let backgroundColor, _):
            return backgroundColor
        case .dialysisCenters(_, let backgroundColor, _):
            return backgroundColor
        case .emergencyCenters(_, let backgroundColor, _):
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
        case .physicalTherapyCenters(_, _, let type):
            return type
        case .opticalCenters(_, _, let type):
            return type
        case .animalHospitals(_, _, let type):
            return type
        case .dialysisCenters(_, _, let type):
            return type
        case .emergencyCenters(_, _, let type):
            return type
        }
    }
}
