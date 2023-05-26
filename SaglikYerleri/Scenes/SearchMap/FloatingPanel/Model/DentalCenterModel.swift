//
//  DentalCenterModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 1.05.2023.
//

import UIKit

// MARK: - DentalCenterModel
struct DentalCenterModel: Codable {
    let status, message: String?
    let rowCount: Int?
    let data: [DentalCenter]?
}

// MARK: - DentalCenter
struct DentalCenter: Codable, OrganizationModel, SharedCell2DataProtocol {
    let name, city, country, street: String?
    let streetv2, phone, fax, website: String?
    let latitude, longitude: Double?

    var sharedCell2ImageBackgroundColor: UIColor {
        return MainHorizontalCollectionData.categoryType(.dentalCenters).tintAndBackgroundColor
    }
    
    var sharedCell2Image: UIImage {
        return MainHorizontalCollectionData.categoryType(.dentalCenters).image
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
    
    var sharedCell2Lat: Double {
        if let latitude {
            return latitude
        }
        return 1.0
    }
    
    var sharedCell2Lng: Double {
        if let longitude {
            return longitude
        }
        return 1.0
    }
    
}
