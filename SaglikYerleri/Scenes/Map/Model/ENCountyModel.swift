//
//  ENCountyModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 1.05.2023.
//

import Foundation

// MARK: - ENCityModel
struct ENCountyModel: Codable {
    let status, message: String?
    let systemTime, rowCount: Int?
    let data: [ENCounty]?
}

// MARK: - ENCounty
struct ENCounty: Codable, CountyModel {
    let cityName, citySlug: String?
}
