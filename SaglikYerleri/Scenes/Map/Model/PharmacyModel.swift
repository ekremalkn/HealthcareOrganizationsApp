//
//  PharmacyModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 29.04.2023.
//

import Foundation

protocol OrganizationModel { }

// MARK: - PharmacyModel
struct PharmacyModel: Codable {
    let status, message: String?
    let rowCount, systemTime: Int?
    let data: [Pharmacy]?
}

// MARK: - Pharmacy
struct Pharmacy: Codable, OrganizationModel {
    let eczaneAdi, adresi, semt, yolTarifi: String?
    let telefon, telefon2, sehir, ilce: String?
    let latitude, longitude: Double?

    enum CodingKeys: String, CodingKey {
        case eczaneAdi = "EczaneAdi"
        case adresi = "Adresi"
        case semt = "Semt"
        case yolTarifi = "YolTarifi"
        case telefon = "Telefon"
        case telefon2 = "Telefon2"
        case sehir = "Sehir"
        case ilce, latitude, longitude
    }
}
