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
    var pharmacyCellData = BehaviorSubject(value: [PharmacyCellData]())
    var sharedCell1Data =  BehaviorSubject(value: [SharedCell1Data]())
    var sharedCell2Data =  BehaviorSubject(value: [SharedCell2Data]())
    
    var cellData = BehaviorSubject(value: [Any]())
    
    //MARK: - DisposeBag
    private let disposeBag = DisposeBag()
    
    //MARK: - Fetch Organizations Data from Core Data
    func getCellData() {
        
        fetchDataFromCoreData { [weak self] in
            guard let self else { return }
            // fetched data from core data, combine observable datas
            let combinedObservableData = Observable.combineLatest(pharmacyCellData, sharedCell1Data, sharedCell2Data)
            
            let mappedObservable = combinedObservableData.map { pharmacyCellData, sharedCell1Data, sharedCell2Data -> [Any] in
                let dataSource: [Any] = pharmacyCellData + sharedCell1Data + sharedCell2Data
                return dataSource // Observable [Any] dönüşü
            }
            
            // create [Any] data for observer onNext
            mappedObservable.subscribe(onNext: { [weak self] result in
                guard let self else { return }
                cellData.onNext(result)
            }).disposed(by: disposeBag)
            
        }
        
        
        
    }
    
    func fetchDataFromCoreData(completion: @escaping () -> Void) {
        // fetch
        DispatchQueue.global().async {
            do {
                let pharmacyData = try self.context.fetch(PharmacyCellData.fetchRequest())
                let sharedCell1Data = try self.context.fetch(SharedCell1Data.fetchRequest())
                let sharedCell2Data = try self.context.fetch(SharedCell2Data.fetchRequest())
                
                DispatchQueue.main.async {
                    self.pharmacyCellData.onNext(pharmacyData)
                    self.sharedCell1Data.onNext(sharedCell1Data)
                    self.sharedCell2Data.onNext(sharedCell2Data)
                    
                    completion()
                }
            } catch {
                print("Core Data'dan veri alınırken hata oluştu: \(error)")
            }
        }
    }
    
    func removeItem(at indexPath: IndexPath) {
        guard var cellData = try? self.cellData.value() else { return }
        
        deleteDataFromCoreData(indexPath: indexPath, cellData: cellData) {
            cellData.remove(at: indexPath.row)
        }
        
        self.cellData.onNext(cellData)
    }
    
    func deleteDataFromCoreData(indexPath: IndexPath, cellData: [Any], completion: () -> Void) {
        // remove from core data
        if let pharmacyCellData = cellData[indexPath.row] as? PharmacyCellData {
            context.delete(pharmacyCellData)
            
        } else if let sharedCell1Data = cellData[indexPath.row] as? SharedCell1Data {
            context.delete(sharedCell1Data)
        } else if let sharedCell2Data = cellData[indexPath.row] as? SharedCell2Data {
            context.delete(sharedCell2Data)
        }
        
        // save the new data
        do {
            try context.save()
            completion()
        } catch {
            print("Cordatadan silme işlemi sırasında hata: \(error)")
        }
        
    }
}

