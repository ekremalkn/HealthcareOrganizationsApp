//
//  MedicalShopCenterModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 6.05.2023.
//

import Foundation

// MARK: - MedicalShopCenterModel
struct MedicalShopCenterModel: Codable {
    let status, message: String?
    let rowCount: Int?
    let data: [MedicalShopCenter]?
}

// MARK: - Datum
struct MedicalShopCenter: Codable, OrganizationModel {
    let name, city, country, street: String?
    let streetv2, phone, fax, website: String?
    let latitude, longitude: Double?
}
