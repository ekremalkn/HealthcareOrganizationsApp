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
    case dutyPharmacies(image: UIImage, title: String, backgroundColor: UIColor)
    case allPharmacies(image: UIImage, title: String, backgroundColor: UIColor)
    case healthCenters(image: UIImage, title: String, backgroundColor: UIColor)
    case hospitals(image: UIImage, title: String, backgroundColor: UIColor)
    case dentalCenters(image: UIImage, title: String, backgroundColor: UIColor)
    case medicalLaboratories(image: UIImage, title: String, backgroundColor: UIColor)
    case radiologyCenters(image: UIImage, title: String, backgroundColor: UIColor)
    case spaCenters(image: UIImage, title: String, backgroundColor: UIColor)
    case psychologistCenters(image: UIImage, title: String, backgroundColor: UIColor)
    
}
