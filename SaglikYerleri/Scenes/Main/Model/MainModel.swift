//
//  MainModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 22.04.2023.
//

import UIKit

enum MainHorizontalCollectionData {
    case dutyPharmacies(image: UIImage, categoryTitle: String)
    case allPharmacies(image: UIImage, categoryTitle: String)
    case healthCenters(image: UIImage, categoryTitle: String)
    case hospitals(image: UIImage, categoryTitle: String)
    case dentalCenters(image: UIImage, categoryTitle: String)
}

extension MainHorizontalCollectionData {
    var image: UIImage {
        switch self {
        case .dutyPharmacies(image: let image, categoryTitle: _):
            return image
        case .allPharmacies(image: let image, categoryTitle: _):
            return image
        case .healthCenters(image: let image, categoryTitle: _):
            return image
        case .hospitals(image: let image, categoryTitle: _):
            return image
        case .dentalCenters(image: let image, categoryTitle: _):
            return image
        }
    }
    
    var categoryTitle: String {
        switch self {
        case .dutyPharmacies( _, let categoryTitle):
            return categoryTitle
        case .allPharmacies( _, let categoryTitle):
            return categoryTitle
        case .healthCenters( _, let categoryTitle):
            return categoryTitle
        case .hospitals( _, let categoryTitle):
            return categoryTitle
        case .dentalCenters( _, let categoryTitle):
            return categoryTitle
        }
    }
    
}

enum MainVerticalCollectionData {
    case dutyPharmacies(title: String, backgroundColor: UIColor)
    case allPharmacies(itle: String, backgroundColor: UIColor)
    case healthCenters(title: String, backgroundColor: UIColor)
    case hospitals(itle: String, backgroundColor: UIColor)
    case dentalCenters(title: String, backgroundColor: UIColor)
    case medicalLaboratories(title: String, backgroundColor: UIColor)
    case radiologyCenters(itle: String, backgroundColor: UIColor)
    case spaCenters(itle: String, backgroundColor: UIColor)
    case psychologistCenters(itle: String, backgroundColor: UIColor)
    case gynecologyCenters(itle: String, backgroundColor: UIColor)
    case physicalTherapyCenters(title: String, backgroundColor: UIColor)
    case opticalCenters(title: String, backgroundColor: UIColor)
    case animalHospitals(itle: String, backgroundColor: UIColor)
    case dialysisCenters(itle: String, backgroundColor: UIColor)
    case emergencyCenters(title: String, backgroundColor: UIColor)
}

extension MainVerticalCollectionData {
    var categoryTitle: String {
        switch self {
        case .dutyPharmacies(let title, _):
            return title
        case .allPharmacies(let title, _):
            return title
        case .healthCenters(let title, _):
            return title
        case .hospitals(let title, _):
            return title
        case .dentalCenters(let title, _):
            return title
        case .medicalLaboratories(let title, _):
            return title
        case .radiologyCenters(let title, _):
            return title
        case .spaCenters(let title, _):
            return title
        case .psychologistCenters(let title, _):
            return title
        case .gynecologyCenters(let title, _):
            return title
        case .physicalTherapyCenters(let title, _):
            return title
        case .opticalCenters(let title, _):
            return title
        case .animalHospitals(let title, _):
            return title
        case .dialysisCenters(let title, _):
            return title
        case .emergencyCenters(let title, _):
            return title
        }
    }
    
    var bacgroundColor: UIColor {
        switch self {
        case .dutyPharmacies(_, let backgroundColor):
            return backgroundColor
        case .allPharmacies(_, let backgroundColor):
            return backgroundColor
        case .healthCenters(_, let backgroundColor):
            return backgroundColor
        case .hospitals(_, let backgroundColor):
            return backgroundColor
        case .dentalCenters(_, let backgroundColor):
            return backgroundColor
        case .medicalLaboratories(_, let backgroundColor):
            return backgroundColor
        case .radiologyCenters(_, let backgroundColor):
            return backgroundColor
        case .spaCenters(_, let backgroundColor):
            return backgroundColor
        case .psychologistCenters(_, let backgroundColor):
            return backgroundColor
        case .gynecologyCenters(_, let backgroundColor):
            return backgroundColor
        case .physicalTherapyCenters(_, let backgroundColor):
            return backgroundColor
        case .opticalCenters(_, let backgroundColor):
            return backgroundColor
        case .animalHospitals(_, let backgroundColor):
            return backgroundColor
        case .dialysisCenters(_, let backgroundColor):
            return backgroundColor
        case .emergencyCenters(_, let backgroundColor):
            return backgroundColor
        }
    }
}
