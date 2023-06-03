//
//  MapViewModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 19.05.2023.
//

import CoreLocation
import RxSwift

final class MapViewModel {
    deinit {
        print("deinit MapViewModel")
    }
    //MARK: - Variables
    var organizations = PublishSubject<(CLLocationCoordinate2D, String)>()
    
    //MARK: - Init Method
    init() {
        
    }
    
    
    
}
