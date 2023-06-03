//
//  PayWallViewModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 24.05.2023.
//

import Foundation
import RxSwift
import FirebaseAuth
import RevenueCat


final class PayWallViewModel {
    deinit {
        print("deinit PayWallViewModel")
    }
    //MARK: - DisposeBag
    private let disposeBag = DisposeBag()
    
    var monthlyPackage: Package?
    var annualPackage: Package?
    
    let userDidNotSignIn = PublishSubject<Void>()
    
    init() {
        getPackages()
    }
    
    private func getPackages() {
        IAPManager.shared.getPackages().subscribe { [weak self] packages in
            guard let self else { return }
            switch packages {
            case .next(let packages):
                packages.forEach { [weak self] package in
                    guard let self else { return }
                    if package.packageType == .monthly {
                        self.monthlyPackage = package
                    } else if package.packageType == .annual {
                        self.annualPackage = package
                    }
                }
            case .error(let error):
                print(error)
            case .completed:
                print("tamamlandı")
            }
        }.disposed(by: disposeBag)
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
    
    func checkUserAndMakePurchase(planType: PayWallPlanButtonType) {
        checkIsCurrentUserActive().flatMap { user in
            return Observable.just(user)
        }.subscribe(onNext: { [weak self] currentUser in
            guard let self else { return }
            if currentUser != nil {
                makePurchase(planType: planType)
            } else {
                userDidNotSignIn.onNext(())
            }
            
        }).disposed(by: disposeBag)
        
    }
    
    private func makePurchase(planType: PayWallPlanButtonType) {
        switch planType {
        case .annual:
            guard let annualPackage else { return }
            IAPManager.shared.makePurchase(package: annualPackage).subscribe { transaction, customerInfo, error, isUserCancelled in
                print(transaction.id)
            }.disposed(by: disposeBag)
        case .monthly:
            guard let monthlyPackage else { return }
            IAPManager.shared.makePurchase(package: monthlyPackage).subscribe { transaction, customerInfo, error, isUserCancelled in
                print(transaction.id)
            }.disposed(by: disposeBag)
        }
    }
}
