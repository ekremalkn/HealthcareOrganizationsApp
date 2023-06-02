//
//  RecentSearchesViewModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 26.05.2023.
//

import Foundation
import UIKit
import RxSwift

final class RecentSearchesViewModel {
    deinit {
        print("RecentSearchesViewModel deinit")
    }
    //MARK: - References
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: - Variables
    var pharmacyCellData = PublishSubject<[PharmacyCellData]>()
    var sharedCell1Data = PublishSubject<[SharedCell1Data]>()
    var sharedCell2Data = PublishSubject<[SharedCell2Data]>()
    
    //MARK: - DisposeBag
    private let disposeBag = DisposeBag()
    
    //MARK: - Fetch Organizations Data from Core Data
    func tableViewDataSource() -> Observable<[Any]> {
        Observable.create { [weak self] observer in
            guard let self else { return Disposables.create() }
            // fetched data from core data, combine observable datas
            let combinedObservableData = Observable.combineLatest(pharmacyCellData, sharedCell1Data, sharedCell2Data)
            
            let mappedObservable = combinedObservableData.map { pharmacyCellData, sharedCell1Data, sharedCell2Data -> [Any] in
                let dataSource: [Any] = pharmacyCellData + sharedCell1Data + sharedCell2Data
                return dataSource // Observable [Any] dönüşü
            }
            
            // create [Any] data for observer onNext
            mappedObservable.subscribe(onNext: { result in
                observer.onNext(result)
            }).disposed(by: disposeBag)
            
            return Disposables.create()
        }
        
    }
    
    func fetchDataFromCoreData() {
        // fetch
        do {
            self.pharmacyCellData.onNext(try self.context.fetch(PharmacyCellData.fetchRequest()))
            self.sharedCell1Data.onNext(try self.context.fetch(SharedCell1Data.fetchRequest()))
            self.sharedCell2Data.onNext(try self.context.fetch(SharedCell2Data.fetchRequest()))
        } catch {
            print("Did occur error while fetching data from coredata error: !!!!!\(error)!!!!!")
        }
    }
    
    
}

