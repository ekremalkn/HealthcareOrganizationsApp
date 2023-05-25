//
//  RemoteConfigManager.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 25.05.2023.
//

import Foundation
import FirebaseRemoteConfig
import RxSwift



final public class RemoteConfigManager {
    static let shared = RemoteConfigManager()
    let remoteConfig = RemoteConfig.remoteConfig()
    
    //MARK: - Init Methods
    private init() {
        configureRemoteConfig()
    }
    
    private func configureRemoteConfig() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
    }
    
    
    public func fetchAndUpdateRemoteConfig(duration: TimeInterval, completion: @escaping (Observable<[MainHorizontalCollectionData]>?) -> Void) {
        remoteConfig.fetch(withExpirationDuration: duration) { [weak self ] status, error in
            guard let self else { return }
            if status == .success {
                print("Remote Config çekildi.")
                self.remoteConfig.activate { [weak self] changed, error in
                    guard let self, error == nil else { return }
                    let pharmacy = self.remoteConfig.configValue(forKey: "pharmacy").boolValue
                    let dutyPharmacy = self.remoteConfig.configValue(forKey: "dutyPharmacy").boolValue
                    let healthCenters = self.remoteConfig.configValue(forKey: "healthCenters").boolValue
                    let hospitals = self.remoteConfig.configValue(forKey: "hospitals").boolValue
                    let dentalCenters = self.remoteConfig.configValue(forKey: "dentalCenters").boolValue
                    let privateDentalCenters = self.remoteConfig.configValue(forKey: "privateDentalCenters").boolValue
                    let medicalLaboratories = self.remoteConfig.configValue(forKey: "medicalLaboratories").boolValue
                    let radiologyCenters = self.remoteConfig.configValue(forKey: "radiologyCenters").boolValue
                    let spaCenters = self.remoteConfig.configValue(forKey: "spaCenters").boolValue
                    let psychologistCenters = self.remoteConfig.configValue(forKey: "psychologistCenters").boolValue
                    let gynecologyCenters = self.remoteConfig.configValue(forKey: "gynecologyCenters").boolValue
                    let opticCenters = self.remoteConfig.configValue(forKey: "opticCenters").boolValue
                    let animalHospitals = self.remoteConfig.configValue(forKey: "animalHospitals").boolValue
                    let dialysisCenters = self.remoteConfig.configValue(forKey: "dialysisCenters").boolValue
                    let emergencyCenters = self.remoteConfig.configValue(forKey: "emergencyCenters").boolValue
                    let medicalShopCenters = self.remoteConfig.configValue(forKey: "medicalShopCenters").boolValue
                    let physiotheraphyCenters = self.remoteConfig.configValue(forKey: "physiotheraphyCenters").boolValue
                    
                    let horizontalCollectionRCdata: [NetworkConstants: Bool] = [
                        .pharmacy : pharmacy,
                        .dutyPharmacy: dutyPharmacy,
                        .healthCenters: healthCenters,
                        .hospitals : hospitals,
                        .dentalCenters : dentalCenters,
                        .privateDentalCenters : privateDentalCenters,
                        .medicalLaboratories : medicalLaboratories,
                        .radiologyCenters : radiologyCenters,
                        .spaCenters : spaCenters,
                        .psychologistCenters : psychologistCenters,
                        .gynecologyCenters : gynecologyCenters,
                        .opticCenters : opticCenters,
                        .animalHospitals : animalHospitals,
                        .dialysisCenters : dialysisCenters,
                        .emergencyCenters : emergencyCenters,
                        .medicalShopCenters : medicalShopCenters,
                        .physiotheraphyCenters : physiotheraphyCenters
                    ]
                 
                    let horizontalCollectionCategories = horizontalCollectionRCdata
                        .filter { $0.value == true }
                        .keys
                        .map { MainHorizontalCollectionData.categoryType($0) }
                    
                    var mainHorizontalCollectionData = Observable<[MainHorizontalCollectionData]>.just(horizontalCollectionCategories)

                    
                    completion(mainHorizontalCollectionData)
                    print("Remote Config verileri başarıyla güncellendi.")
                }
            } else {
                completion(nil)
                print("Config not fetched")
                print("Veri çekme hatası: \(error?.localizedDescription ?? "No error available")")
            }
        }
        
        
    }
}
