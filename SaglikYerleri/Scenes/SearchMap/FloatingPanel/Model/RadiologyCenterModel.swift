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
struct RadiologyCenter: Codable, OrganizationModel, MRHHCellDataProtocol {
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
 
    var mrhhImageBackgroundColor: UIColor {
        return MainCollectionData.categoryType(.radiologyCenters).backgroundColor
    }
    
    var mrhhImage: UIImage {
        return UIImage(named: "duty")!
    }
    
    var mrhhName: String {
        if let ad {
            return ad
        }
        return "Kurum adı bulunamadı"
    }
    
    var mrhhCityCountyName: String {
        if let sehir, let ilce {
            return "\(sehir)/\(ilce)"
        }
        return "Il/Ilçe bilgisi yok"
    }
    
    var mrhhAddress: String {
        if let adres {
            return adres
        }
        return "Adres bilgisi yok"
    }
    
    var mrhhPhone: String {
        if let tel {
            return tel
        }
        return "Telefon bilgisi yok"
    }
    
    var mrhhEmail: String {
        if let email {
            return email
        }
        return "Email bilgisi yok"
    }
}
