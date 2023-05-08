//
//  GynecologyCenterModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 1.05.2023.
//

import UIKit

// MARK: - GynecologyCenterModel
struct GynecologyCenterModel: Codable {
    let status, message: String?
    let rowCount: Int?
    let data: [GynecologyCenter]?
}

// MARK: - GynecologyCenter
struct GynecologyCenter: Codable, OrganizationModel {
    let name, city, country, street: String?
    let streetv2, phone, fax, website: String?
    let latitude, longitude: Double?
    
    var gynecologyImageBackgroundColor: UIColor {
        return MainCollectionData.categoryType(.gynecologyCenters).backgroundColor
    }
}
