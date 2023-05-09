//
//  DentalCenterModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 1.05.2023.
//

import UIKit

// MARK: - DentalCenterModel
struct DentalCenterModel: Codable {
    let status, message: String?
    let rowCount: Int?
    let data: [DentalCenter]?
}

// MARK: - DentalCenter
struct DentalCenter: Codable, OrganizationModel {
    let name, city, country, street: String?
    let streetv2, phone, fax, website: String?
    let latitude, longitude: Double?
    
    var dentalImageBackgroundColor: UIColor {
        return MainCollectionData.categoryType(.dentalCenters).backgroundColor
    }
    
    var dentalImage: UIImage {
        return MainHorizontalCollectionData.categoryType(.dentalCenters).image
    }
}
