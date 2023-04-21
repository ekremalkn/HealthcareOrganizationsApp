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
        MainHorizontalCollectionData.dutyPharmacies(image: UIImage(systemName: "cross")!, categoryTitle: "Nöbetçi Eczaneler"),
        MainHorizontalCollectionData.hospitals(image: UIImage(systemName: "cross")!, categoryTitle: "Tüm Hastaneler"),
        MainHorizontalCollectionData.allPharmacies(image: UIImage(systemName: "cross")!, categoryTitle: "Tüm Eczaneler"),
        MainHorizontalCollectionData.dentalCenters(image: UIImage(systemName: "cross")!, categoryTitle: "Diş Sağlığı Merkezleri"),
        MainHorizontalCollectionData.healthCenters(image: UIImage(systemName: "cross")!, categoryTitle: "Sağlık Ocakları")
    ])
}
