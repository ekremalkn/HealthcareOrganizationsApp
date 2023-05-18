//
//  PharmacyModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 29.04.2023.
//

import UIKit

protocol OrganizationModel { }

// MARK: - PharmacyModel
struct PharmacyModel: Codable {
    let status, message: String?
    let rowCount, systemTime: Int?
    let data: [Pharmacy]?
}

// MARK: - Pharmacy
struct Pharmacy: Codable, OrganizationModel, PharmacyCellDataProtocol {
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
    
    var pharmacyImageBackgroundColor: UIColor {
        return MainCollectionData.categoryType(.dutyPharmacy).backgroundColor
    }
    
    var pharmacyImage: UIImage {
        return MainHorizontalCollectionData.categoryType(.dutyPharmacy).image
    }
    
    var pharmacyName: String {
        if let eczaneAdi {
            return eczaneAdi
        }
        return "Eczane ismi bulunamadı"
    }
    
    var pharmacyCityCountyName: String {
        if let sehir, let ilce {
            return "\(sehir)/\(ilce)"
        }
        return "Sehir ya da ilçe bulunamadı"
    }
    
    var pharmacyDistrictName: String {
        if let semt {
            return semt
        }
        return "Semt yok"
    }
    
    var pharmacyAddress: String {
        if let adresi {
            return adresi
        }
        return "Adresi yok"
    }
    
    var pharmacyPhone1: String {
        if let telefon {
            return telefon
        }
        return ""
    }
    
    var pharmacyPhone2: String {
        if let telefon2 {
            return telefon2
        }
        return ""
    }
    
    var pharmacyDirections: String {
        if let yolTarifi {
            return yolTarifi
        }
        return ""
    }
    
    var pharmacyLat: Double {
        if let latitude {
            return latitude
        }
        return 0.0
    }
    
    var pharmacyLng: Double {
        if let longitude {
            return longitude
        }
        return 0.0
    }
    
}
