//
//  PhysiotheraphyCenterModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 6.05.2023.
//

import Foundation

// MARK: - PhysiotheraphyCenterModel
struct PhysiotheraphyCenterModel: Codable {
    let status, message: String?
    let rowCount: Int?
    let data: [PhysiotheraphyCenter]?
}

// MARK: - PhysiotheraphyCenter
struct PhysiotheraphyCenter: Codable, OrganizationModel {
    let name, city, country, street: String?
    let streetv2, phone, fax, website: String?
    let latitude, longitude: Double?
}
