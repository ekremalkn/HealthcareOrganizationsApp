//
//  SharedCell2Data+CoreDataClass.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 29.05.2023.
//
//

import Foundation
import UIKit
import CoreData

@objc(SharedCell2Data)
public class SharedCell2Data: NSManagedObject, SharedCell2DataProtocol {
    var sharedCell2ImageBackgroundColor: String {
        if let imageBackgroundColor {
            return imageBackgroundColor
        }
        return ""
    }
    
    var sharedCell2Image: String {
        if let image {
            return image
        }
        return ""
    }
    
    var sharedCell2Name: String {
        if let name {
            return name
        }
        return ""
    }
    
    var sharedCell2Street: String {
        if let street {
            return street
        }
        return ""
    }
    
    var sharedCell2Phone: String {
        if let phone {
            return phone
        }
        return ""
    }
    
    var sharedCell2Fax: String {
        return ""
    }
    
    var sharedCell2WebSite: String {
        if let webSite {
            return webSite
        }
        return ""
    }
    
    var sharedCell2Lat: Double {
        lat
    }
    
    var sharedCell2Lng: Double {
        lng
    }
}
