//
//  GynecologyCenterModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 1.05.2023.
//

import Foundation

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
    let distanceMT: Int?
    let distanceKM, distanceMil: Double?

    enum CodingKeys: String, CodingKey {
        case name, city, country, street, streetv2, phone, fax, website, latitude, longitude
        case distanceMT = "distanceMt"
        case distanceKM = "distanceKm"
        case distanceMil
    }
}
