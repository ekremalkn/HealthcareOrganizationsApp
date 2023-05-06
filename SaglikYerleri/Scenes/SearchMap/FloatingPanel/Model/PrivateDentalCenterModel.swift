//
//  PrivateDentalCenterModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 6.05.2023.
//

import Foundation

// MARK: - PrivateDentalCenterModel
struct PrivateDentalCenterModel: Codable {
    let status, message: String?
    let rowCount: Int?
    let data: [PrivateDentalCenter]?
}

// MARK: - PrivateDentalCenter
struct PrivateDentalCenter: Codable, OrganizationModel {
    let name, city, country, street: String?
    let streetv2, phone, fax, website: String?
    let latitude, longitude: Double?
}
