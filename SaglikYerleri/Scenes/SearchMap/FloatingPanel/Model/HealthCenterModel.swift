//
//  HealthCenterModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 1.05.2023.
//

import UIKit

// MARK: - HealthCenterModel
struct HealthCenterModel: Codable {
    let status, message: String?
    let rowCount, systemTime: Int?
    let data: [HealthCenter]?
}

// MARK: - HealthCenter
struct HealthCenter: Codable, OrganizationModel {
    let ad, adres, tel: String?
    let email: String?
    let website: String?
    let sehir, ilce: String?
    let latitude, longitude: Double?

    enum CodingKeys: String, CodingKey {
        case ad = "Ad"
        case adres = "Adres"
        case tel = "Tel"
        case email = "Email"
        case website = "Website"
        case sehir = "Sehir"
        case ilce, latitude, longitude
    }
    
    var healthCenterImageBackgroundColor: UIColor {
        return MainCollectionData.categoryType(.healthCenters).backgroundColor
    }
    
    var healthCenterImage: UIImage {
        return MainHorizontalCollectionData.categoryType(.healthCenters).image
    }
}
