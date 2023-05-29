//
//  CellData+CoreDataProperties.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 29.05.2023.
//
//

import Foundation
import CoreData


extension CellData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CellData> {
        return NSFetchRequest<CellData>(entityName: "CellData")
    }

    @NSManaged public var pharmayCells: NSSet?
    @NSManaged public var shared1Cells: NSSet?
    @NSManaged public var shared2Cells: NSSet?

}

// MARK: Generated accessors for pharmayCells
extension CellData {

    @objc(addPharmayCellsObject:)
    @NSManaged public func addToPharmayCells(_ value: PharmacyCellData)

    @objc(removePharmayCellsObject:)
    @NSManaged public func removeFromPharmayCells(_ value: PharmacyCellData)

    @objc(addPharmayCells:)
    @NSManaged public func addToPharmayCells(_ values: NSSet)

    @objc(removePharmayCells:)
    @NSManaged public func removeFromPharmayCells(_ values: NSSet)

}

// MARK: Generated accessors for shared1Cells
extension CellData {

    @objc(addShared1CellsObject:)
    @NSManaged public func addToShared1Cells(_ value: SharedCell1Data)

    @objc(removeShared1CellsObject:)
    @NSManaged public func removeFromShared1Cells(_ value: SharedCell1Data)

    @objc(addShared1Cells:)
    @NSManaged public func addToShared1Cells(_ values: NSSet)

    @objc(removeShared1Cells:)
    @NSManaged public func removeFromShared1Cells(_ values: NSSet)

}

// MARK: Generated accessors for shared2Cells
extension CellData {

    @objc(addShared2CellsObject:)
    @NSManaged public func addToShared2Cells(_ value: SharedCell2Data)

    @objc(removeShared2CellsObject:)
    @NSManaged public func removeFromShared2Cells(_ value: SharedCell2Data)

    @objc(addShared2Cells:)
    @NSManaged public func addToShared2Cells(_ values: NSSet)

    @objc(removeShared2Cells:)
    @NSManaged public func removeFromShared2Cells(_ values: NSSet)

}

extension CellData : Identifiable {

}
