//
//  EmergencyCenterModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 6.05.2023.
//

import UIKit

// MARK: - EmergencyCenterModel
struct EmergencyCenterModel: Codable {
    let status, message: String?
    let rowCount: Int?
    let data: [EmergencyCenter]?
}

// MARK: - Datum
struct EmergencyCenter: Codable, OrganizationModel {
    let name, city, country, street: String?
    let streetv2, phone, fax, website: String?
    let latitude, longitude: Double?
    
    var emergencyCenterImageBackgroundColor: UIColor {
        return MainCollectionData.categoryType(.emergencyCenters).backgroundColor
    }
        
}
