//
//  SharedCell1Data+CoreDataClass.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 29.05.2023.
//
//

import Foundation
import UIKit
import CoreData

@objc(SharedCell1Data)
public class SharedCell1Data: NSManagedObject, SharedCell1DataProtocol {
    var sharedCell1ImageBackgroundColor: String {
        if let imageBackroundColor {
            return imageBackroundColor
        }
        return ""
    }
    
    var sharedCell1Image: String {
        if let image {
            return image
        }
        return ""
    }
    
    var sharedCell1Name: String {
        if let name {
            return name
        }
        return ""
    }
    
    var sharedCell1Address: String {
        if let address {
            return address
        }
        return ""
    }
    
    var sharedCell1Phone: String {
        if let phone {
            return phone
        }
        return ""
    }
    
    var sharedCell1Email: String {
        if let email {
            return email
        }
        return ""
    }
    
    var sharedCell1Lat: Double {
        lat
    }
    
    var sharedCell1Lng: Double {
        lng
    }
}
