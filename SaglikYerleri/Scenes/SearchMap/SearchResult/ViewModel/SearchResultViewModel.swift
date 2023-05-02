//
//  SearchResultViewModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 2.05.2023.
//

import Foundation
import RxSwift

class SearchResultViewModel {
    
    //MARK: - Category Type
    let categoryType: NetworkConstants?
    
    //MARK: - Variables
    let cities = PublishSubject<[CityModel]>()
    
    //MARK: - Dispose Bag
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Init Methods
    init(categoryType: NetworkConstants) {
        self.categoryType = categoryType
    }
    
    //MARK: - Fetch Cities
    func fetchCities() {
        guard let categoryType else { return }
                
        switch categoryType {
        case .hospitals:
            NetworkService.shared.getTRCities(type: .hospitals).subscribe { [weak self] event in
                switch event {
                case .next(let hospitalCities):
                    guard let hospitalCities = hospitalCities?.data else { return }
                    self?.cities.onNext(hospitalCities)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .healthCenters:
            NetworkService.shared.getTRCities(type: .healthCenters).subscribe { [weak self] event in
                switch event {
                case .next(let healthCenterCities):
                    guard let healthCenterCities = healthCenterCities?.data else { return }
                    self?.cities.onNext(healthCenterCities)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .dentalCenters:
            NetworkService.shared.getENCities(type: .dentalCenters).subscribe { [weak self] event in
                switch event {
                case .next(let dentalCenterCities):
                    guard let dentalCenterCities = dentalCenterCities?.data else { return }
                    self?.cities.onNext(dentalCenterCities)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .pharmacy:
            NetworkService.shared.getTRCities(type: .pharmacy).subscribe { [weak self] event in
                switch event {
                case .next(let pharmacyCities):
                    guard let pharmacyCities = pharmacyCities?.data else { return }
                    self?.cities.onNext(pharmacyCities)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .medicalLaboratories:
            NetworkService.shared.getENCities(type: .medicalLaboratories).subscribe { [weak self] event in
                switch event {
                case .next(let medicalLaboratoryCities):
                    guard let medicalLaboratoryCities = medicalLaboratoryCities?.data else { return }
                    self?.cities.onNext(medicalLaboratoryCities)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .radiologyCenters:
            NetworkService.shared.getTRCities(type: .radiologyCenters).subscribe { [weak self] event in
                switch event {
                case .next(let radiologyCenterCities):
                    guard let radiologyCenterCities = radiologyCenterCities?.data else { return }
                    self?.cities.onNext(radiologyCenterCities)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .animalHospitals:
            NetworkService.shared.getENCities(type: .hospitals).subscribe { [weak self] event in
                switch event {
                case .next(let animalHospitalCities):
                    guard let animalHospitalCities = animalHospitalCities?.data else { return }
                    self?.cities.onNext(animalHospitalCities)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .psychologistCenters:
            NetworkService.shared.getENCities(type: .psychologistCenters).subscribe { [weak self] event in
                switch event {
                case .next(let psychologistCenterCities):
                    guard let psychologistCenterCities = psychologistCenterCities?.data else { return }
                    self?.cities.onNext(psychologistCenterCities)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .gynecologyCenters:
            NetworkService.shared.getENCities(type: .gynecologyCenters).subscribe { [weak self] event in
                switch event {
                case .next(let gynecologyCenterCities):
                    guard let gynecologyCenterCities = gynecologyCenterCities?.data else { return }
                    self?.cities.onNext(gynecologyCenterCities)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .optikCenters:
            NetworkService.shared.getENCities(type: .optikCenters).subscribe { [weak self] event in
                switch event {
                case .next(let optikCenterCities):
                    guard let optikCenterCities = optikCenterCities?.data else { return }
                    self?.cities.onNext(optikCenterCities)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        }
    }
    
    //MARK: - Fetch Counties
    func fetchCounties(city: String) {
        guard let categoryType else { return }
        
        switch categoryType {
        case .hospitals:
            NetworkService.shared.getTRCounties(type: .hospitals, city: city).subscribe { [weak self] event in
                switch event {
                case .next(let hospitalCounties):
                    guard let hospitalCounties = hospitalCounties?.data else { return }
                    self?.cities.onNext(hospitalCounties)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .healthCenters:
            NetworkService.shared.getENcounties(type: .healthCenters, city: city).subscribe { [weak self] event in
                switch event {
                case .next(let healthCenterCounties):
                    guard let healthCenterCounties = healthCenterCounties?.data else { return }
                    self?.cities.onNext(healthCenterCounties)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .dentalCenters:
            NetworkService.shared.getENcounties(type: .dentalCenters, city: city).subscribe { [weak self] event in
                switch event {
                case .next(let dentalCenterCounties):
                    guard let dentalCenterCounties = dentalCenterCounties?.data else { return }
                    self?.cities.onNext(dentalCenterCounties)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .pharmacy:
            NetworkService.shared.getTRCounties(type: .pharmacy, city: city).subscribe { [weak self] event in
                switch event {
                case .next(let pharmacyCounties):
                    guard let pharmacyCounties = pharmacyCounties?.data else { return }
                    print(pharmacyCounties)
                    self?.cities.onNext(pharmacyCounties)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .medicalLaboratories:
            NetworkService.shared.getENcounties(type: .medicalLaboratories, city: city).subscribe { [weak self] event in
                switch event {
                case .next(let medicalLaboratoryCounties):
                    guard let medicalLaboratoryCounties = medicalLaboratoryCounties?.data else { return }
                    self?.cities.onNext(medicalLaboratoryCounties)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .radiologyCenters:
            NetworkService.shared.getTRCounties(type: .radiologyCenters, city: city).subscribe { [weak self] event in
                switch event {
                case .next(let radiologyCenterCounties):
                    guard let radiologyCenterCounties = radiologyCenterCounties?.data else { return }
                    self?.cities.onNext(radiologyCenterCounties)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .animalHospitals:
            NetworkService.shared.getENcounties(type: .animalHospitals, city: city).subscribe { [weak self] event in
                switch event {
                case .next(let animalHospitalCounties):
                    guard let animalHospitalCounties = animalHospitalCounties?.data else { return }
                    self?.cities.onNext(animalHospitalCounties)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .psychologistCenters:
            NetworkService.shared.getENcounties(type: .psychologistCenters, city: city).subscribe { [weak self] event in
                switch event {
                case .next(let psychologistCenterCounties):
                    guard let psychologistCenterCounties = psychologistCenterCounties?.data else { return }
                    self?.cities.onNext(psychologistCenterCounties)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .gynecologyCenters:
            NetworkService.shared.getENcounties(type: .gynecologyCenters, city: city).subscribe { [weak self] event in
                switch event {
                case .next(let gynecologyCenterCounties):
                    guard let gynecologyCenterCounties = gynecologyCenterCounties?.data else { return }
                    self?.cities.onNext(gynecologyCenterCounties)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .optikCenters:
            NetworkService.shared.getENcounties(type: .optikCenters, city: city).subscribe { [weak self] event in
                switch event {
                case .next(let optikCenterCounties):
                    guard let optikCenterCounties = optikCenterCounties?.data else { return }
                    self?.cities.onNext(optikCenterCounties)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        }
    }
}
