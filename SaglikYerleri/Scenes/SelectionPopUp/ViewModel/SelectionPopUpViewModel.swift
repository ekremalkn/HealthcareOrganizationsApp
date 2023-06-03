//
//  SelectionPopUpViewModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 2.06.2023.
//

import RxSwift
import FirebaseAuth

final class SelectionPopUpViewModel {
    
    //MARK: - CollectionViewDatas
    let collectionViewData = Observable.just([
        MainHorizontalCollectionData.categoryType(.hospitals),
        MainHorizontalCollectionData.categoryType(.healthCenters),
        MainHorizontalCollectionData.categoryType(.dentalCenters),
        MainHorizontalCollectionData.categoryType(.pharmacy),
        MainHorizontalCollectionData.categoryType(.dutyPharmacy),
        MainHorizontalCollectionData.categoryType(.dialysisCenters),
        MainHorizontalCollectionData.categoryType(.physiotheraphyCenters),
        MainHorizontalCollectionData.categoryType(.privateDentalCenters),
        MainHorizontalCollectionData.categoryType(.opticCenters),
        MainHorizontalCollectionData.categoryType(.emergencyCenters),
        MainHorizontalCollectionData.categoryType(.medicalShopCenters),
        MainHorizontalCollectionData.categoryType(.spaCenters),
        MainHorizontalCollectionData.categoryType(.medicalLaboratories),
        MainHorizontalCollectionData.categoryType(.radiologyCenters),
        MainHorizontalCollectionData.categoryType(.animalHospitals),
        MainHorizontalCollectionData.categoryType(.psychologistCenters),
        MainHorizontalCollectionData.categoryType(.gynecologyCenters)
    ])
    
    let freeCollectionCategories: [MainHorizontalCollectionData] = [
        MainHorizontalCollectionData.categoryType(.dutyPharmacy),
        MainHorizontalCollectionData.categoryType(.emergencyCenters),
        MainHorizontalCollectionData.categoryType(.healthCenters),
        MainHorizontalCollectionData.categoryType(.pharmacy),
        MainHorizontalCollectionData.categoryType(.medicalLaboratories),
        MainHorizontalCollectionData.categoryType(.psychologistCenters),
        MainHorizontalCollectionData.categoryType(.opticCenters),
        MainHorizontalCollectionData.categoryType(.radiologyCenters)
    ]
    //MARK: - Dispose Bag
    private let disposeBag = DisposeBag()


}

extension SelectionPopUpViewModel {
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
