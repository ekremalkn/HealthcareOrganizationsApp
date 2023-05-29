//
//  PharmacyCellData+CoreDataProperties.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 29.05.2023.
//
//

import Foundation
import CoreData


extension PharmacyCellData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PharmacyCellData> {
        return NSFetchRequest<PharmacyCellData>(entityName: "PharmacyCellData")
    }

    @NSManaged public var address: String?
    @NSManaged public var directions: String?
    @NSManaged public var image: String?
    @NSManaged public var imageBackgroundColor: String?
    @NSManaged public var lat: Double
    @NSManaged public var lng: Double
    @NSManaged public var name: String?
    @NSManaged public var phone1: String?
    @NSManaged public var phone2: String?
    @NSManaged public var pharmacyCells: CellData?

}

extension PharmacyCellData : Identifiable {

}
