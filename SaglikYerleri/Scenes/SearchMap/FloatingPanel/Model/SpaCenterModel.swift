//
//  SpaCenterModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 6.05.2023.
//

import UIKit

// MARK: - SpaCenterModel
struct SpaCenterModel: Codable {
    let status, message: String?
    let rowCount: Int?
    let data: [SpaCenter]?
}

// MARK: - SpaCenter
struct SpaCenter: Codable, OrganizationModel {
    let name, city, country, street: String?
    let streetv2, phone, fax, website: String?
    let latitude, longitude: Double?
    
    var spaCenterImageBackgroundColor: UIColor {
        return MainCollectionData.categoryType(.spaCenters).backgroundColor
    }
}
