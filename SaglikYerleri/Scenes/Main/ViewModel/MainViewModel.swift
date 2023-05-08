//
//  MainViewModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 22.04.2023.
//

import UIKit
import RxSwift

final class MainViewModel {
    
    let horizontalCollectionData = Observable.just([
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
    
}
