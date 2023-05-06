//
//  TRCountyModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 29.04.2023.
//

import Foundation

protocol CountyModel {}

// MARK: - TRCountyModel
struct TRCountyModel: Codable {
    let status, message: String?
    let systemTime, rowCount: Int?
    let data: [TRCounty]?
}

// MARK: - TRCounty
struct TRCounty: Codable, CityModel {
    let ilceAd, ilceSlug: String?
}
