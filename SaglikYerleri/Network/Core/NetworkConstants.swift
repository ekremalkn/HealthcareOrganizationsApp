//
//  NetworkConstants.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 27.04.2023.
//

import Foundation

protocol NetworkConstantsProtocol {
    var cityConstant: String { get }
    var orgnizationConstant: String { get }
}

public enum NetworkConstants: NetworkConstantsProtocol {
    case pharmacy
    case healthCenters
    case hospitals
    case dentalCenters
    case privateDentalCenters
    case medicalLaboratories
    case radiologyCenters
    case spaCenters
    case psychologistCenters
    case gynecologyCenters
    case opticCenters
    case animalHospitals
    case dialysisCenters
    case emergencyCenters
    case medicalShopCenters
    case physiotheraphyCenters
    
    
    var cityConstant: String {
        switch self {
        case .hospitals:
            return "https://www.nosyapi.com/apiv2/hospital/getCity"
        case .healthCenters:
            return "https://www.nosyapi.com/apiv2/clinic/getCity"
        case .dentalCenters:
            return "https://www.nosyapi.com/apiv2/getTurkeyCity?id=80051"
        case .pharmacy:
            return "https://www.nosyapi.com/apiv2/pharmacy/city"
        case .medicalLaboratories:
            return "https://www.nosyapi.com/apiv2/lab/getCity"
        case .radiologyCenters:
            return "https://www.nosyapi.com/apiv2/radiology/getCity"
        case .animalHospitals:
            return "https://www.nosyapi.com/apiv2/getTurkeyCity?id=95930"
        case .psychologistCenters:
            return "https://www.nosyapi.com/apiv2/getTurkeyCity?id=60704"
        case .gynecologyCenters:
            return "https://www.nosyapi.com/apiv2/getTurkeyCity?id=48626"
        case .opticCenters:
            return "https://www.nosyapi.com/apiv2/getTurkeyCity?id=56968"
        case .privateDentalCenters:
            return "https://www.nosyapi.com/apiv2/getTurkeyCity?id=99373"
        case .spaCenters:
            return "https://www.nosyapi.com/apiv2/getTurkeyCity?id=32148"
        case .dialysisCenters:
            return "https://www.nosyapi.com/apiv2/getTurkeyCity?id=90607"
        case .emergencyCenters:
            return "https://www.nosyapi.com/apiv2/getTurkey?id=24590"
        case .medicalShopCenters:
            return "https://www.nosyapi.com/apiv2/getTurkeyCity?id=79448"
        case .physiotheraphyCenters:
            return "https://www.nosyapi.com/apiv2/getTurkeyCity?id=43049"
        }
    }
    
    var orgnizationConstant: String {
        switch self {
        case .hospitals:
            return "https://www.nosyapi.com/apiv2/hospital"
        case .healthCenters:
            return "https://www.nosyapi.com/apiv2/clinic"
        case .dentalCenters:
            return "https://www.nosyapi.com/apiv2/getTurkey?id=80051"
        case .pharmacy:
            return "https://www.nosyapi.com/apiv2/pharmacy"
        case .medicalLaboratories:
            return "https://www.nosyapi.com/apiv2/lab"
        case .radiologyCenters:
            return "https://www.nosyapi.com/apiv2/radiology"
        case .animalHospitals:
            return "https://www.nosyapi.com/apiv2/getTurkey?id=95930"
        case .psychologistCenters:
            return "https://www.nosyapi.com/apiv2/getTurkey?id=60704"
        case .gynecologyCenters:
            return "https://www.nosyapi.com/apiv2/getTurkey?id=48626"
        case .opticCenters:
            return "https://www.nosyapi.com/apiv2/getTurkey?id=56968"
        case .privateDentalCenters:
            return "https://www.nosyapi.com/apiv2/getTurkey?id=99373"
        case .spaCenters:
            return "https://www.nosyapi.com/apiv2/getTurkey?id=32148"
        case .dialysisCenters:
            return "https://www.nosyapi.com/apiv2/getTurkey?id=90607"
        case .emergencyCenters:
            return "https://www.nosyapi.com/apiv2/getTurkey?id=24590"
        case .medicalShopCenters:
            return "https://www.nosyapi.com/apiv2/getTurkey?id=79448"
        case .physiotheraphyCenters:
            return "https://www.nosyapi.com/apiv2/getTurkeyCity?id=43049"
        }
    }
    

}

