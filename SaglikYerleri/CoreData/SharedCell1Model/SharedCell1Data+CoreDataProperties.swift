//
//  SharedCell1Data+CoreDataProperties.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 29.05.2023.
//
//

import Foundation
import CoreData


extension SharedCell1Data {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SharedCell1Data> {
        return NSFetchRequest<SharedCell1Data>(entityName: "SharedCell1Data")
    }

    @NSManaged public var address: String?
    @NSManaged public var email: String?
    @NSManaged public var image: String?
    @NSManaged public var imageBackroundColor: String?
    @NSManaged public var lat: Double
    @NSManaged public var lng: Double
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var shared1Cells: CellData?

}

extension SharedCell1Data : Identifiable {

}
