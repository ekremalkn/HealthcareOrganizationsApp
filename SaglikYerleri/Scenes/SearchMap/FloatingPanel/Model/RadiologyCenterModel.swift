//
//  RadiologyModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 1.05.2023.
//

import UIKit

// MARK: - RadiologyCenterModel
struct RadiologyCenterModel: Codable {
    let status, message: String?
    let rowCount: Int?
    let data: [RadiologyCenter]?
}

// MARK: - RadiologyCenter
struct RadiologyCenter: Codable, OrganizationModel, SharedCell1DataProtocol {
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
 
    var sharedCell1ImageBackgroundColor: UIColor {
        return MainHorizontalCollectionData.categoryType(.radiologyCenters).tintAndBackgroundColor
    }
    
    var sharedCell1Image: UIImage {
        return MainHorizontalCollectionData.categoryType(.radiologyCenters).image
    }
    
    var sharedCell1Name: String {
        if let ad {
            return ad
        }
        return "Kurum adı bulunamadı"
    }
    
    var sharedCell1CityCountyName: String {
        if let sehir, let ilce {
            return "\(sehir)/\(ilce)"
        }
        return "Il/Ilçe bilgisi yok"
    }
    
    var sharedCell1Address: String {
        if let adres {
            return adres
        }
        return "Adres bilgisi yok"
    }
    
    var sharedCell1Phone: String {
        if let tel {
            return tel
        }
        return "Telefon bilgisi yok"
    }
    
    var sharedCell1Email: String {
        if let email {
            return email
        }
        return "Email bilgisi yok"
    }
    
    var sharedCell1Lat: Double {
        if let latitude {
            return latitude
        }
        return 1.0
    }
    
    var sharedCell1Lng: Double {
        if let longitude  {
            return longitude
        }
        return 1.0
    }
    
}
