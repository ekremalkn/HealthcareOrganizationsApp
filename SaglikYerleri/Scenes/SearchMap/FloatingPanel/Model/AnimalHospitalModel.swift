//
//  AnimalHospitalModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 1.05.2023.
//

import UIKit

// MARK: - AnimalHospitalModel
struct AnimalHospitalModel: Codable {
    let status, message: String?
    let rowCount: Int?
    let data: [AnimalHospital]?
}

// MARK: - AnimalHospital
struct AnimalHospital: Codable, OrganizationModel {
    let name, city, country, street: String?
    let streetv2, phone, fax, website: String?
    let latitude, longitude: Double?
    
    var animalHospitalImageBackgroundColor: UIColor {
        return MainCollectionData.categoryType(.animalHospitals).backgroundColor
    }
}
