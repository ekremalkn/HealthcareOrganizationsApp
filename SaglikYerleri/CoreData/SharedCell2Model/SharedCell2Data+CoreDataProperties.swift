//
//  SharedCell2Data+CoreDataProperties.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 29.05.2023.
//
//

import Foundation
import CoreData


extension SharedCell2Data {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SharedCell2Data> {
        return NSFetchRequest<SharedCell2Data>(entityName: "SharedCell2Data")
    }

    @NSManaged public var image: String?
    @NSManaged public var imageBackgroundColor: String?
    @NSManaged public var lat: Double
    @NSManaged public var lng: Double
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var street: String?
    @NSManaged public var webSite: String?
    @NSManaged public var shared2Cells: CellData?

}

extension SharedCell2Data : Identifiable {

}
