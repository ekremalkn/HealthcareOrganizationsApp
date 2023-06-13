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
    
    let freeMainCollectionCategories: [MainCollectionData] = [
        MainCollectionData.categoryType(.dutyPharmacy),
        MainCollectionData.categoryType(.emergencyCenters),
        MainCollectionData.categoryType(.healthCenters),
        MainCollectionData.categoryType(.pharmacy),
        MainCollectionData.categoryType(.medicalLaboratories),
        MainCollectionData.categoryType(.psychologistCenters),
        MainCollectionData.categoryType(.opticCenters),
        MainCollectionData.categoryType(.radiologyCenters)
    ]
    
    let freeHorizontalCollectionCategories: [MainHorizontalCollectionData] = [
        MainHorizontalCollectionData.categoryType(.dutyPharmacy),
        MainHorizontalCollectionData.categoryType(.emergencyCenters),
        MainHorizontalCollectionData.categoryType(.healthCenters),
        MainHorizontalCollectionData.categoryType(.pharmacy),
        MainHorizontalCollectionData.categoryType(.medicalLaboratories),
        MainHorizontalCollectionData.categoryType(.psychologistCenters),
        MainHorizontalCollectionData.categoryType(.opticCenters),
        MainHorizontalCollectionData.categoryType(.radiologyCenters)
    ]
    
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
            IAPManager.shared.getUserPremiumStatus().subscribe { [weak self] result in
                guard let _ = self else { return }
                switch result {
                case .next(let userSubscriptionStatus):
                    observer.onNext(userSubscriptionStatus)
                case .error(let error):
                    observer.onError(error)
                case .completed:
                    print("kullanıcı subscription status işlemi tamamlandı")
                }
            }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
        
    }
    
}

