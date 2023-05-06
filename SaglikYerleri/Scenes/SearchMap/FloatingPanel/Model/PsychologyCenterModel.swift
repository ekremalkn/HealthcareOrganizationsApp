//
//  PsychologyCenterModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 1.05.2023.
//

import Foundation

// MARK: - PsychologyCenterModel
struct PsychologyCenterModel: Codable {
    let status, message: String?
    let rowCount: Int?
    let data: [PsychologistCenter]?
}

// MARK: - PsychologyCenter
struct PsychologistCenter: Codable, OrganizationModel {
    let name, city, country, street: String?
    let streetv2, phone, fax, website: String?
    let latitude, longitude: Double?
}
