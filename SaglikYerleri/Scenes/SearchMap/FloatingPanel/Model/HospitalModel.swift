//
//  HospitalModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 1.05.2023.
//

import UIKit

// MARK: - HospitalModel
struct HospitalModel: Codable {
    let status, message: String?
    let rowCount, systemTime: Int?
    let data: [Hospital]?
}

// MARK: - Hospital
struct Hospital: Codable, OrganizationModel {
    let ad, adres, tel, email: String?
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
    
    var hospitalImageBackgroundColor: UIColor {
        return MainHorizontalCollectionData.categoryType(.hospitals).tintAndBackgroundColor
    }
    
    var hospitalImage: UIImage {
        return MainHorizontalCollectionData.categoryType(.hospitals).image
    }
    
}

