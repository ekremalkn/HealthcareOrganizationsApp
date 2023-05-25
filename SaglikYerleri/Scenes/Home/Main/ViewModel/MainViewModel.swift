//
//  MainViewModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 22.04.2023.
//

import RxSwift

final class MainViewModel {
    
    //MARK: - DisposeBag
    private let disposeBag = DisposeBag()
    
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
    
    
    init(mainHorizontalCollectionRemoteConfigData: Observable<[MainHorizontalCollectionData]>?) {
        guard let mainHorizontalCollectionRemoteConfigData else { return }
        self.horizontalCollectionData = mainHorizontalCollectionRemoteConfigData
    }
}


//MARK: - Check Subscription Status
extension MainViewModel {
    func checkSubscriptionStatus() -> Observable<Bool> {
        Observable.create { [unowned self] observer in
            IAPManager.shared.getCustomerInfo().subscribe { [weak self] result in
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
            return Disposables.create()
        }
        
    }
}

