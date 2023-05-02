//
//  CityModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 29.04.2023.
//

import Foundation

protocol CityModel {}

// MARK: - CityModel
struct TRCityModel: Codable  {
    var status, message: String
    var systemTime, rowCount: Int
    let data: [TRCity]?
}

// MARK: - TRCity
struct TRCity: Codable, CityModel {
    let sehirAd, sehirSlug: String?

    enum CodingKeys: String, CodingKey {
        case sehirAd = "SehirAd"
        case sehirSlug = "SehirSlug"
    }
}
