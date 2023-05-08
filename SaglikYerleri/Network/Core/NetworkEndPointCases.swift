//
//  NetworkEndPointCases.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 29.04.2023.
//

import Alamofire

public enum NetworkEndPointCases: NetworkEndPoint {

    
    case getCityList(type: NetworkConstants)
    case getCountyList(type: NetworkConstants ,city: String)
    case getHealthOrganizationList(type: NetworkConstants, city: String, county: String)
    
    var apiKey: String {
        return NetworkAPIConstant.API_KEY.rawValue
    }
    
    var headers: HTTPHeaders {
        return [
            "Authorization": "Bearer \(NetworkAPIConstant.API_KEY.rawValue)"
        ]
    }
    
    var path: String {
        switch self {
        case .getCityList(let type):
            switch type {
            case .hospitals:
                return type.cityConstant
            case .healthCenters:
                return type.cityConstant
            case .dentalCenters:
                return type.cityConstant
            case .pharmacy:
                return type.cityConstant
            case .medicalLaboratories:
                return type.cityConstant
            case .radiologyCenters:
                return type.cityConstant
            case .animalHospitals:
                return type.cityConstant
            case .psychologistCenters:
                return type.cityConstant
            case .gynecologyCenters:
                return type.cityConstant
            case .opticCenters:
                return type.cityConstant
            case .privateDentalCenters:
                return type.cityConstant
            case .spaCenters:
                return type.cityConstant
            case .dialysisCenters:
                return type.cityConstant
            case .emergencyCenters:
                return type.cityConstant
            case .medicalShopCenters:
                return type.cityConstant
            case .physiotheraphyCenters:
                return type.cityConstant
            case .dutyPharmacy:
                return type.cityConstant
            }
            
        case .getCountyList(let type, let city):
            switch type {
            case .hospitals:
                return type.cityConstant + "?city=\(city)"
            case .healthCenters:
                return type.cityConstant + "?city=\(city)"
            case .dentalCenters:
                return type.cityConstant + "&city=\(city)"
            case .pharmacy:
                return type.cityConstant + "?city=\(city)"
            case .medicalLaboratories:
                return type.cityConstant + "&city=\(city)"
            case .radiologyCenters:
                return type.cityConstant + "?city=\(city)"
            case .animalHospitals:
                return type.cityConstant + "&city=\(city)"
            case .psychologistCenters:
                return type.cityConstant + "&city=\(city)"
            case .gynecologyCenters:
                return type.cityConstant + "&city=\(city)"
            case .opticCenters:
                return type.cityConstant + "&city=\(city)"
            case .privateDentalCenters:
                return type.cityConstant + "&city=\(city)"
            case .spaCenters:
                return type.cityConstant + "&city=\(city)"
            case .dialysisCenters:
                return type.cityConstant + "&city=\(city)"
            case .emergencyCenters:
                return type.cityConstant + "&city=\(city)"
            case .medicalShopCenters:
                return type.cityConstant + "&city=\(city)"
            case .dutyPharmacy:
                return type.cityConstant + "?city=\(city)"
            case .physiotheraphyCenters:
                return type.cityConstant + "&city=\(city)"
            }
            
        case .getHealthOrganizationList(type: let type, city: let city, county: let county):
            switch type {
            case .hospitals:
                return type.orgnizationConstant + "?city=\(city)&county=\(county)"
            case .healthCenters:
                return type.orgnizationConstant + "?city=\(city)&county=\(county)"
            case .dentalCenters:
                return type.orgnizationConstant + "&city=\(city)&country=\(county)"
            case .pharmacy:
                return type.orgnizationConstant + "?city=\(city)&county=\(county)"
            case .medicalLaboratories:
                return type.orgnizationConstant + "&city=\(city)&country=\(county)"
            case .radiologyCenters:
                return type.orgnizationConstant + "?city=\(city)&county=\(county)"
            case .animalHospitals:
                return type.orgnizationConstant + "&city=\(city)&country=\(county)"
            case .psychologistCenters:
                return type.orgnizationConstant + "&city=\(city)&country=\(county)"
            case .gynecologyCenters:
                return type.orgnizationConstant + "&city=\(city)&country=\(county)"
            case .opticCenters:
                return type.orgnizationConstant + "&city=\(city)&country=\(county)"
            case .privateDentalCenters:
                return type.orgnizationConstant + "&city=\(city)&country=\(county)"
            case .spaCenters:
                return type.orgnizationConstant + "&city=\(city)&country=\(county)"
            case .dialysisCenters:
                return type.orgnizationConstant + "&city=\(city)&country=\(county)"
            case .emergencyCenters:
                return type.orgnizationConstant + "&city=\(city)&country=\(county)"
            case .medicalShopCenters:
                return type.orgnizationConstant + "&city=\(city)&country=\(county)"
            case .physiotheraphyCenters:
                return type.orgnizationConstant + "&city=\(city)&country=\(county)"
            case .dutyPharmacy:
                return type.orgnizationConstant + "?city=\(city)&county=\(county)"
            }
        }
    }
    
    
    
}
