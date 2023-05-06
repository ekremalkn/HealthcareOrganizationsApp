//
//  DentalCenterModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 1.05.2023.
//

import Foundation

// MARK: - DentalCenterModel
struct DentalCenterModel: Codable {
    let status, message: String?
    let rowCount: Int?
    let data: [Dental]?
}

// MARK: - Dental
struct Dental: Codable, OrganizationModel {
    let name, city, country, street: String?
    let streetv2, phone, fax, website: String?
    let latitude, longitude: Double?
}
