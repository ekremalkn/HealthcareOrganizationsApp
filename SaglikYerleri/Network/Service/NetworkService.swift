//
//  NetworkService.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 28.04.2023.
//

import Foundation
import RxSwift

protocol NetworkServiceProtocol {
    func getTRCities(type: NetworkConstants) -> Observable<TRCityModel?>
    func getENCities(type: NetworkConstants) -> Observable<ENCityModel?>
    func getTRCounties(type: NetworkConstants, city: String) -> Observable<TRCountyModel?>
    func getENcounties(type: NetworkConstants, city: String) -> Observable<ENCountyModel?>
    func getHealthOrganizations<T: Decodable>(type: NetworkConstants, city: String, county: String) -> Observable<T?>
}

final class NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()
    
    func getTRCities(type: NetworkConstants) -> Observable<TRCityModel?>{
        let endpoint = NetworkEndPointCases.getCityList(type: type)
        
        return NetworkManager.shared.request(path: endpoint.path, headers: endpoint.headers, bearerToken: endpoint.apiKey).asObservable()
    }
    
    func getENCities(type: NetworkConstants) -> Observable<ENCityModel?> {
        let endpoint = NetworkEndPointCases.getCityList(type: type)
        
        return NetworkManager.shared.request(path: endpoint.path, headers: endpoint.headers, bearerToken: endpoint.apiKey).asObservable()
    }
    
    func getTRCounties(type: NetworkConstants, city: String) -> Observable<TRCountyModel?> {
        let endpoint = NetworkEndPointCases.getCountyList(type: type, city: city)
        
        return NetworkManager.shared.request(path: endpoint.path, headers: endpoint.headers, bearerToken: endpoint.apiKey).asObservable()
    }
    
    func getENcounties(type: NetworkConstants, city: String) -> Observable<ENCountyModel?> {
        let endpoint = NetworkEndPointCases.getCountyList(type: type, city: city)
        
        return NetworkManager.shared.request(path: endpoint.path, headers: endpoint.headers, bearerToken: endpoint.apiKey).asObservable()
    }
    
    func getHealthOrganizations<T: Decodable>(type: NetworkConstants, city: String, county: String) -> Observable<T?> {
        let endpoint = NetworkEndPointCases.getHealthOrganizationList(type: type, city: city, county: county)
        
        switch type {
        case .hospitals:
            let observable: Observable<HospitalModel> = NetworkManager.shared.request(path: endpoint.path, headers: endpoint.headers, bearerToken: endpoint.apiKey).asObservable()
            return observable.map { $0 as? T }
        case .healthCenters:
            let observable: Observable<HealthCenterModel?> = NetworkManager.shared.request(path: endpoint.path, headers: endpoint.headers, bearerToken: endpoint.apiKey).asObservable()
            return observable.map { $0 as? T }
        case .dentalCenters:
            let observable: Observable<DentalCenterModel?> = NetworkManager.shared.request(path: endpoint.path, headers: endpoint.headers, bearerToken: endpoint.apiKey).asObservable()
            return observable.map { $0 as? T }
        case .pharmacy:
            let observable: Observable<PharmacyModel?> = NetworkManager.shared.request(path: endpoint.path, headers: endpoint.headers, bearerToken: endpoint.apiKey).asObservable()
            return observable.map { $0 as? T }
        case .medicalLaboratories:
            let observable: Observable<MedicalLaboratoryModel?> = NetworkManager.shared.request(path: endpoint.path, headers: endpoint.headers, bearerToken: endpoint.apiKey).asObservable()
            return observable.map { $0 as? T }
        case .radiologyCenters:
            let observable: Observable<RadiologyCenterModel?> = NetworkManager.shared.request(path: endpoint.path, headers: endpoint.headers, bearerToken: endpoint.apiKey).asObservable()
            return observable.map { $0 as? T }
        case .animalHospitals:
            let observable: Observable<AnimalHospitalModel?> = NetworkManager.shared.request(path: endpoint.path, headers: endpoint.headers, bearerToken: endpoint.apiKey).asObservable()
            return observable.map { $0 as? T }
        case .psychologistCenters:
            let observable: Observable<PsychologyCenterModel?> = NetworkManager.shared.request(path: endpoint.path, headers: endpoint.headers, bearerToken: endpoint.apiKey).asObservable()
            return observable.map { $0 as? T }
        case .gynecologyCenters:
            let observable: Observable<GynecologyCenterModel?> = NetworkManager.shared.request(path: endpoint.path, headers: endpoint.headers, bearerToken: endpoint.apiKey).asObservable()
            return observable.map { $0 as? T }
        case .opticCenters:
            let observable: Observable<OptikCenterModel?> = NetworkManager.shared.request(path: endpoint.path, headers: endpoint.headers, bearerToken: endpoint.apiKey).asObservable()
            return observable.map { $0 as? T }
        case .privateDentalCenters:
            let observable: Observable<PrivateDentalCenterModel?>  = NetworkManager.shared.request(path: endpoint.path, headers: endpoint.headers, bearerToken: endpoint.apiKey)
            return observable.map { $0 as? T }
        case .spaCenters:
            let observable: Observable<SpaCenterModel?> = NetworkManager.shared.request(path: endpoint.path, headers: endpoint.headers, bearerToken: endpoint.apiKey)
            return observable.map { $0 as? T }
        case .dialysisCenters:
            let observable: Observable<DialysisCenterModel?> = NetworkManager.shared.request(path: endpoint.path, headers: endpoint.headers, bearerToken: endpoint.apiKey)
            return observable.map { $0 as? T }
        case .emergencyCenters:
            let obseravble: Observable<EmergencyCenterModel?> = NetworkManager.shared.request(path: endpoint.path, headers: endpoint.headers, bearerToken: endpoint.apiKey)
            return obseravble.map { $0 as? T}
        case .medicalShopCenters:
            let observable: Observable<EmergencyCenterModel?> = NetworkManager.shared.request(path: endpoint.path, headers: endpoint.headers, bearerToken: endpoint.apiKey)
            return observable.map { $0 as? T}
        case .physiotheraphyCenters:
            let observable: Observable<PhysiotheraphyCenterModel?> = NetworkManager.shared.request(path: endpoint.path, headers: endpoint.headers, bearerToken: endpoint.apiKey)
            return observable.map { $0 as? T}
        case .dutyPharmacy:
            let observable: Observable<PharmacyModel?> = NetworkManager.shared.request(path: endpoint.path, headers: endpoint.headers, bearerToken: endpoint.apiKey)
            return observable.map{ $0 as? T}
        }
       

    }
    
}
