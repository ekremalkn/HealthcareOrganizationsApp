//
//  ENCityModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 1.05.2023.
//

import Foundation

// MARK: - ENCityModel
struct ENCityModel: Codable {
    let status, message: String?
    let systemTime, rowCount: Int?
    let data: [ENCities]?
}

// MARK: - ENCities
struct ENCities: Codable, CityModel {
    let cityName, citySlug: String?
}
