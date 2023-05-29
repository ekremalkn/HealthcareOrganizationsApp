//
//  PharmacyCellData+CoreDataClass.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 29.05.2023.
//
//

import Foundation
import UIKit
import CoreData

@objc(PharmacyCellData)
public class PharmacyCellData: NSManagedObject, PharmacyCellDataProtocol {
    var pharmacyImageBackgroundColor: String {
        if let imageBackgroundColor {
            return imageBackgroundColor
        }
        return ""
    }
    
    var pharmacyImage: String {
        if let image {
            return image
        }
        return ""
    }
    
    var pharmacyName: String {
        if let name {
            return name
        }
        return ""
    }
    
    var pharmacyAddress: String {
        if let address {
            return address
        }
        return ""
    }
    
    var pharmacyPhone1: String {
        if let phone1 {
            return phone1
        }
        return ""
    }
    
    var pharmacyPhone2: String {
        if let phone2 {
            return phone2
        }
        return ""
    }
    
    var pharmacyDirections: String {
        if let directions {
            return directions
        }
        return ""
    }
    
    var pharmacyLat: Double {
        lat
    }
    
    var pharmacyLng: Double {
        lng
    }
}
