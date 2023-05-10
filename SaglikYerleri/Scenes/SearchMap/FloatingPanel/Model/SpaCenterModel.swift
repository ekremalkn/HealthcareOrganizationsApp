//
//  SpaCenterModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 6.05.2023.
//

import UIKit

// MARK: - SpaCenterModel
struct SpaCenterModel: Codable {
    let status, message: String?
    let rowCount: Int?
    let data: [SpaCenter]?
}

// MARK: - SpaCenter
struct SpaCenter: Codable, OrganizationModel, SharedCell2DataProtocol {
    let name, city, country, street: String?
    let streetv2, phone, fax, website: String?
    let latitude, longitude: Double?

    var sharedCell2ImageBackgroundColor: UIColor {
        return MainCollectionData.categoryType(.spaCenters).backgroundColor
    }
    
    var sharedCell2Image: UIImage {
        return MainHorizontalCollectionData.categoryType(.spaCenters).image
    }
    
    var sharedCell2Name: String {
        if let name {
            return name
        }
        return "Kurum adı bulunamadı"
    }
    
    var sharedCell2CityCountyName: String {
        if let city, let country {
            return "\(city)/\(country)"
        }
        return "Il/Ilçe bilgisi yok"
    }
    
    var sharedCell2Street: String {
        if let street {
            if let streetv2 {
                return "\(street)/\(streetv2)"
            } else {
                return street
            }
        }
        return "Cadde bilgisi yok"
    }
    
    var sharedCell2Phone: String {
        if let phone {
            return phone
        }
        return "Telefon bilgisi yok"
    }
    
    var sharedCell2Fax: String {
        if let fax {
            return fax
        }
        return "Fax bilgisi yok"
    }
    
    var sharedCell2WebSite: String {
        if let website {
            return website
        }
        return "Website bilgisi yok"
    }
}
