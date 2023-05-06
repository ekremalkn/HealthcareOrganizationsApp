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
    let data: [ENCity]?
}

// MARK: - ENCity
struct ENCity: Codable, CityModel {
    let cityName, citySlug: String?
}
