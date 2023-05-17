//
//  CityModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 29.04.2023.
//

import Foundation

enum CityCountyType {
    case city
    case county
}

protocol CityCountyModel where Self: Codable {
    var name: String? { get }
    var slugName: String? { get }
    var type: CityCountyType { get }
}

// MARK: - CityModel
struct TRCityModel: Codable  {
    var status, message: String?
    var systemTime, rowCount: Int?
    let data: [TRCity]?
}

// MARK: - TRCity
struct TRCity: Codable, CityCountyModel {
    let sehirAd, sehirSlug: String?

    enum CodingKeys: String, CodingKey {
        case sehirAd = "SehirAd"
        case sehirSlug = "SehirSlug"
    }
    
    var name: String? {
        sehirAd
    }
    
    var slugName: String? {
        sehirSlug
    }
    
    var type: CityCountyType {
        .city
    }
    

        
}
