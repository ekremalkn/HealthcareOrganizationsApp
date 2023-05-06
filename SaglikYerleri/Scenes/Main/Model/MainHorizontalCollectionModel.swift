//
//  MainHorizontalCollectionModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 6.05.2023.
//

import UIKit

enum MainHorizontalCollectionData {
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
