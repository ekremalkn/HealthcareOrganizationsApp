//
//  OptikCenterModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 1.05.2023.
//

import UIKit

// MARK: - OptikCenterModel
struct OptikCenterModel: Codable {
    let status, message: String?
    let rowCount: Int?
    let data: [OptikCenter]?
}

// MARK: - OptikCenter
struct OptikCenter: Codable, OrganizationModel {
    let name, city, country, street: String?
    let streetv2, phone, fax, website: String?
    let latitude, longitude: Double?
    
    var optikCenterImageBackgroundColor: UIColor {
        return MainCollectionData.categoryType(.opticCenters).backgroundColor
    }
}
