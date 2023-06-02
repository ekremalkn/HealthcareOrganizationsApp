//
//  MainViewModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 22.04.2023.
//

import RxSwift
import FirebaseAuth

final class MainViewModel {

    //MARK: - CollectionView Datas
    var horizontalCollectionData = Observable.just([
        MainHorizontalCollectionData.categoryType(.dutyPharmacy),
        MainHorizontalCollectionData.categoryType(.hospitals),
        MainHorizontalCollectionData.categoryType(.dentalCenters),
        MainHorizontalCollectionData.categoryType(.healthCenters)
    ])
    
    let mainCollectionData = Observable.just([
        MainCollectionData.categoryType(.hospitals),
        MainCollectionData.categoryType(.healthCenters),
        MainCollectionData.categoryType(.dentalCenters),
        MainCollectionData.categoryType(.pharmacy),
        MainCollectionData.categoryType(.dutyPharmacy),
        MainCollectionData.categoryType(.dialysisCenters),
        MainCollectionData.categoryType(.physiotheraphyCenters),
        MainCollectionData.categoryType(.privateDentalCenters),
        MainCollectionData.categoryType(.opticCenters),
        MainCollectionData.categoryType(.emergencyCenters),
        MainCollectionData.categoryType(.medicalShopCenters),
        MainCollectionData.categoryType(.spaCenters),
        MainCollectionData.categoryType(.medicalLaboratories),
        MainCollectionData.categoryType(.radiologyCenters),
        MainCollectionData.categoryType(.animalHospitals),
        MainCollectionData.categoryType(.psychologistCenters),
        MainCollectionData.categoryType(.gynecologyCenters)
    ])
    
    //MARK: - DisposeBag
    private let disposeBag = DisposeBag()
        
    init(mainHorizontalCollectionRemoteConfigData: Observable<[MainHorizontalCollectionData]>?) {
        guard let mainHorizontalCollectionRemoteConfigData else { return }
        self.horizontalCollectionData = mainHorizontalCollectionRemoteConfigData
    }
    
}


//MARK: - Check Subscription Status
extension MainViewModel {
    func checkSubscriptionStatus() -> Observable<Bool> {
        return Observable.create { [unowned self] observer in
            checkIsCurrentUserActive().flatMap { user in
                return Observable.just(user)
            }.subscribe(onNext: { user in
                if user != nil { // Check if user already sign in with provider and has account on firebase
                    IAPManager.shared.getUserPremiumStatus().subscribe { [weak self] result in
                        guard let _ = self else { return }
                        switch result {
                        case .next(let userSubscriptionStatus):
                            observer.onNext(userSubscriptionStatus)
                            
                        case .error(let error):
                            print(error.localizedDescription)
                        case .completed:
                            print("kullanıcı subscription status işlemi tamamlandı")
                        }
                    }.disposed(by: self.disposeBag)
                } else { // Check if user did not sign in with provider and has not account on firebase
                    observer.onNext(false)
                }
            }).disposed(by: disposeBag)
            
            return Disposables.create()
        }
        
    }
    
    private func checkIsCurrentUserActive() -> Observable<User?> {
        return Observable.create { observer in
            if let currentUser = Auth.auth().currentUser {
                observer.onNext(currentUser)
            } else {
                observer.onNext(nil)
            }
            return Disposables.create()
        }
    }
    
    
}

