//
//  PayWallViewModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 24.05.2023.
//

import Foundation
import RxSwift
import RevenueCat


final class PayWallViewModel {
    deinit {
        print("deinit PayWallViewModel")
    }
    //MARK: - DisposeBag
    private let disposeBag = DisposeBag()
    
    //MARK: - References
    var iapService: IAPService
    
    var monthlyPackage: Package?
    var annualPackage: Package?
        
    init(iapService: IAPService) {
        self.iapService = iapService
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
    
    
    func checkUserAndMakePurchase(planType: PayWallPlanButtonType) {
        makePurchase(planType: planType)
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
    
    func restorePurchase() {
        iapService.restorePurchases().subscribe { result in
            switch result {
                
            case .next(let isRestored):
                isRestored ? print("restored başarılı") : print("restored başarısız")
            case .error(let error):
                print(error.localizedDescription)
            case .completed:
                break
            }
        }.disposed(by: disposeBag)
    }
}
