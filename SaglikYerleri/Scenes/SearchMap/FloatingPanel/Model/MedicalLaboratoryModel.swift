//
//  MedicalLaboratoryModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 1.05.2023.
//

import UIKit

// MARK: - MedicalLaboratoryModel
struct MedicalLaboratoryModel: Codable {
    let status, message: String?
    let rowCount: Int?
    let data: [MedicalLaboratory]?
}

// MARK: - Datum
struct MedicalLaboratory: Codable, OrganizationModel {
    let ad, aciklama, adres, tel: String?
    let email: String?
    let website: String?
    let sehir, ilce: String?
    let latitude, longitude: Double?

    enum CodingKeys: String, CodingKey {
        case ad = "Ad"
        case aciklama = "Aciklama"
        case adres = "Adres"
        case tel = "Tel"
        case email = "Email"
        case website = "Website"
        case sehir = "Sehir"
        case ilce, latitude, longitude
    }
    
    var medicalLaboratoryImageBackgroundColor: UIColor {
        return MainCollectionData.categoryType(.medicalLaboratories).backgroundColor
    }
}
