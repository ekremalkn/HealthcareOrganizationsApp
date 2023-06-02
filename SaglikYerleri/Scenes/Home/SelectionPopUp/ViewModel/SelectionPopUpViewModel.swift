//
//  SelectionPopUpViewModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 2.06.2023.
//

import RxSwift

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
    
    

}
