//
//  SplashViewModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 1.06.2023.
//

import RxSwift
import Foundation

final class SplashViewModel {
    deinit {
        print("SplashViewModel deinit")
    }
    
    
    func fetchAndUpdateRemoteConfig(completion: @escaping (Observable<[MainHorizontalCollectionData]>?) -> Void)  {
        RemoteConfigManager.shared.fetchAndUpdateRemoteConfig(duration: 0) { mainHorizontalCollectionData in
            completion(mainHorizontalCollectionData)
        }
    }
    
    func setAndCheckIsFirstLaunch(completion: (Bool) -> Void) {
        let isFirstLaunchKey = "isFirstLaunch"
        let userDefaults = UserDefaults.standard
        
        if userDefaults.bool(forKey: isFirstLaunchKey) {
            // önceden açılmış
            completion(false)
        } else {
            // ilk defa açılıyor
            userDefaults.set(true, forKey: isFirstLaunchKey)
            completion(true)
        }
    }
}
