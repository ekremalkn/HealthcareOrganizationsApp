//
//  IAPManager.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 24.05.2023.
//

import Foundation
import RxSwift
import RevenueCat

protocol IAPService {
    func getPackages() -> Observable<[Package]>
    func makePurchase(package: Package) -> Observable<(StoreTransaction, CustomerInfo, PublicError, Bool)>
    func restorePurchases()
    func getCustomerInfo() -> Observable<Bool>
}


final public class IAPManager: IAPService {
    static let shared: IAPService = IAPManager()
    
    //MARK: - DisposeBag
    private let disposeBag = DisposeBag()
    
    private func getOfferings() -> Observable<Offerings> {
        return Observable.create { observer in
            Purchases.shared.getOfferings { offerings, error in
                guard error == nil else { observer.onError(error!); return }
                
                guard let offerings else { return }
                
                observer.onNext(offerings)
                observer.onCompleted()
                
            }
            return Disposables.create()
        }
    }
    
    public func getPackages() -> Observable<[Package]> {
        return Observable.create { [unowned self] observer in
            self.getOfferings().flatMap { offerings in
                
                return Observable.just(offerings)
            }.subscribe { result in
                switch result {
                case .next(let offerings):
                    guard let packages = offerings.current?.availablePackages else { return }
                    observer.onNext(packages)
                case .error(let error):
                    observer.onError(error)
                case .completed:
                    observer.onCompleted()
                }
            }.disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
        
    }
    
    public func makePurchase(package: Package) -> Observable<(StoreTransaction, CustomerInfo, PublicError, Bool)> {
        Observable.create { observer in
            Purchases.shared.purchase(package: package) { transaction, customerInfo, error, isUserCancelled in
            }
            return Disposables.create()
        }
    }
    
    func restorePurchases() {
        Purchases.shared.restorePurchases { (customerInfo, error) in
            //UNUTMA APPLE BUNU ISTIYOR
            //... check customerInfo to see if entitlement is now active
        }
    }
    
    public func getCustomerInfo() -> Observable<Bool> {
        Observable.create { observer in
            // Check User is subscribe or not
            Purchases.shared.getCustomerInfo { customerInfo, error in
                if let error {
                    observer.onError(error)
                } else {
                    if customerInfo?.entitlements.all[IAPConstants.entitlementIdentifier.rawValue]?.isActive == true {
                        observer.onNext(true)
                    } else {
                        observer.onNext(false)
                    }
                }
                observer.onCompleted()
                
            }
            return Disposables.create()
            
        }
    }
    
    
}
