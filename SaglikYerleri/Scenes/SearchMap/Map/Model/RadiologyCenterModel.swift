//
//  RadiologyModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 1.05.2023.
//

import Foundation

// MARK: - RadiologyCenterModel
struct RadiologyCenterModel: Codable {
    let status, message: String?
    let rowCount: Int?
    let data: [RadiologyCenter]?
}

// MARK: - RadiologyCenter
struct RadiologyCenter: Codable, OrganizationModel {
    let ad, aciklama, adres, tel: String?
    let email: String?
    let website: String?
    let sehir, ilce: String?
    let latitude, longitude: Double?

    enum CodingKeys: String, CodingKey {
        case ad = "Ad"
        case aciklama = "Aciklama"
        case adres = "Adres"
        case tel = "Tel"
        case email = "Email"
        case website = "Website"
        case sehir = "Sehir"
        case ilce, latitude, longitude
    }
}
