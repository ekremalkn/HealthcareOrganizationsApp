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
    let citiesCounties = PublishSubject<[CityModel]>()
    var cityCountyArray = [CityModel]()
    
    let fetchingCities = PublishSubject<Bool>()
    let fetchedCities = PublishSubject<Void>()
    let errorMsg = PublishSubject<String>()
    
    //MARK: - Dispose Bag
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Init Methods
    init(categoryType: NetworkConstants) {
        self.categoryType = categoryType
    }
    
    //MARK: - Handle City Event
    private func handleTRCityModel(_ event: Event<TRCityModel?> ) {
        switch event {
        case .next(let cities):
            guard let cities = cities?.data else { return }
            self.setLoadingAnimateState(fetchingCities: false, fetchedCities: (), errorMsg: nil)
            self.citiesCounties.onNext(cities)
            self.cityCountyArray = cities
        case .error(let error):
            self.setLoadingAnimateState(fetchingCities: nil, fetchedCities: nil, errorMsg: error.localizedDescription)
        case .completed:
            print("success")
        }
        
    }
    
    private func handleENCityModel(_ event: Event<ENCityModel?>) {
        switch event {
        case .next(let cities):
            guard let cities = cities?.data else { return }
            self.setLoadingAnimateState(fetchingCities: false, fetchedCities: (), errorMsg: nil)
            self.citiesCounties.onNext(cities)
            self.cityCountyArray = cities
        case .error(let error):
            self.setLoadingAnimateState(fetchingCities: nil, fetchedCities: nil, errorMsg: error.localizedDescription)
        case .completed:
            print("success")
        }
    }
    
    //MARK: - Fetch Cities
    func fetchCities() {
        guard let categoryType else { return }
        self.setLoadingAnimateState(fetchingCities: true)
        
        switch categoryType {
        case .hospitals:
            NetworkService.shared.getTRCities(type: categoryType).subscribe { [weak self] event in
                self?.handleTRCityModel(event)
            }.disposed(by: disposeBag)
        case .healthCenters:
            NetworkService.shared.getTRCities(type: categoryType).subscribe { [weak self] event in
                self?.handleTRCityModel(event)
            }.disposed(by: disposeBag)
        case .dentalCenters:
            NetworkService.shared.getENCities(type: categoryType).subscribe { [weak self] event in
                self?.handleENCityModel(event)
            }.disposed(by: disposeBag)
        case .pharmacy:
            NetworkService.shared.getTRCities(type: categoryType).subscribe { [weak self] event in
                self?.handleTRCityModel(event)
            }.disposed(by: disposeBag)
        case .medicalLaboratories:
            NetworkService.shared.getTRCities(type: categoryType).subscribe { [weak self] event in
                self?.handleTRCityModel(event)
            }.disposed(by: disposeBag)
        case .radiologyCenters:
            NetworkService.shared.getTRCities(type: categoryType).subscribe { [weak self] event in
                self?.handleTRCityModel(event)
            }.disposed(by: disposeBag)
        case .animalHospitals:
            NetworkService.shared.getENCities(type: categoryType).subscribe { [weak self] event in
                self?.handleENCityModel(event)
            }.disposed(by: disposeBag)
        case .psychologistCenters:
            NetworkService.shared.getENCities(type: categoryType).subscribe { [weak self] event in
                self?.handleENCityModel(event)
            }.disposed(by: disposeBag)
        case .gynecologyCenters:
            NetworkService.shared.getENCities(type: categoryType).subscribe { [weak self] event in
                self?.handleENCityModel(event)
            }.disposed(by: disposeBag)
        case .opticCenters:
            NetworkService.shared.getENCities(type: categoryType).subscribe { [weak self] event in
                self?.handleENCityModel(event)
            }.disposed(by: disposeBag)
        case .privateDentalCenters:
            NetworkService.shared.getENCities(type: categoryType).subscribe { [weak self] event in
                self?.handleENCityModel(event)
            }.disposed(by: disposeBag)
        case .spaCenters:
            NetworkService.shared.getENCities(type: categoryType).subscribe { [weak self] event in
                self?.handleENCityModel(event)
            }.disposed(by: disposeBag)
        case .dialysisCenters:
            NetworkService.shared.getENCities(type: categoryType).subscribe { [weak self] event in
                self?.handleENCityModel(event)
            }.disposed(by: disposeBag)
        case .emergencyCenters:
            NetworkService.shared.getENCities(type: categoryType).subscribe { [weak self] event in
                self?.handleENCityModel(event)
            }.disposed(by: disposeBag)
        case .medicalShopCenters:
            NetworkService.shared.getENCities(type: categoryType).subscribe { [weak self] event in
                self?.handleENCityModel(event)
            }.disposed(by: disposeBag)
        case .physiotheraphyCenters:
            NetworkService.shared.getENCities(type: categoryType).subscribe { [weak self] event in
                self?.handleENCityModel(event)
            }.disposed(by: disposeBag)
        case .dutyPharmacy:
            NetworkService.shared.getTRCities(type: categoryType).subscribe { [weak self] event in
                self?.handleTRCityModel(event)
            }.disposed(by: disposeBag)
        }
    }
    
    
    //MARK: - Handle County Event
    private func handleTRCountyModel(_ event: Event<TRCountyModel?> ) {
        switch event {
        case .next(let counties):
            guard let counties = counties?.data else { return }
            self.setLoadingAnimateState(fetchingCities: false, fetchedCities: (), errorMsg: nil)
            self.citiesCounties.onNext(counties)
            self.cityCountyArray = counties
        case .error(let error):
            self.setLoadingAnimateState(fetchingCities: nil, fetchedCities: nil, errorMsg: error.localizedDescription)
        case .completed:
            print("success")
        }
    }
    
    private func handleENCountyModel(_ event: Event<ENCountyModel?>) {
        switch event {
        case .next(let counties):
            guard let counties = counties?.data else { return }
            self.setLoadingAnimateState(fetchingCities: false, fetchedCities: (), errorMsg: nil)
            self.citiesCounties.onNext(counties)
            self.cityCountyArray = counties
        case .error(let error):
            self.setLoadingAnimateState(fetchingCities: nil, fetchedCities: nil, errorMsg: error.localizedDescription)
        case .completed:
            print("success")
        }
    }
    
    //MARK: - Fetch Counties
    func fetchCounties(city: String) {
        guard let categoryType else { return }
        
        switch categoryType {
        case .hospitals:
            NetworkService.shared.getTRCounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleTRCountyModel(event)
            }.disposed(by: disposeBag)
        case .healthCenters:
            NetworkService.shared.getTRCounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleTRCountyModel(event)
            }.disposed(by: disposeBag)
        case .dentalCenters:
            NetworkService.shared.getENcounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleENCountyModel(event)
            }.disposed(by: disposeBag)
        case .pharmacy:
            NetworkService.shared.getTRCounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleTRCountyModel(event)
            }.disposed(by: disposeBag)
        case .medicalLaboratories:
            NetworkService.shared.getTRCounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleTRCountyModel(event)
            }.disposed(by: disposeBag)
        case .radiologyCenters:
            NetworkService.shared.getTRCounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleTRCountyModel(event)
            }.disposed(by: disposeBag)
        case .animalHospitals:
            NetworkService.shared.getENcounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleENCountyModel(event)
            }.disposed(by: disposeBag)
        case .psychologistCenters:
            NetworkService.shared.getENcounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleENCountyModel(event)
            }.disposed(by: disposeBag)
        case .gynecologyCenters:
            NetworkService.shared.getENcounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleENCountyModel(event)
            }.disposed(by: disposeBag)
        case .opticCenters:
            NetworkService.shared.getENcounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleENCountyModel(event)
            }.disposed(by: disposeBag)
        case .privateDentalCenters:
            NetworkService.shared.getENcounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleENCountyModel(event)
            }.disposed(by: disposeBag)
        case .spaCenters:
            NetworkService.shared.getENcounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleENCountyModel(event)
            }.disposed(by: disposeBag)
        case .dialysisCenters:
            NetworkService.shared.getENcounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleENCountyModel(event)
            }.disposed(by: disposeBag)
        case .emergencyCenters:
            NetworkService.shared.getENcounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleENCountyModel(event)
            }.disposed(by: disposeBag)
        case .medicalShopCenters:
            NetworkService.shared.getENcounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleENCountyModel(event)
            }.disposed(by: disposeBag)
        case .physiotheraphyCenters:
            NetworkService.shared.getENcounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleENCountyModel(event)
            }.disposed(by: disposeBag)
        case .dutyPharmacy:
            NetworkService.shared.getTRCounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleTRCountyModel(event)
            }.disposed(by: disposeBag)
        }
    }
    
    //MARK: - Filter Cities / Counties
    func filterCityCounty(character: String) {
        let filteredCitiesCounties = cityCountyArray.filter { cityModel in
            switch cityModel {
            case let city as ENCity:
                guard let cityName = city.cityName else { return false }
                return cityName.lowercased().hasPrefix(character.lowercased())
            case let county as ENCounty:
                guard let countyName = county.cityName else { return false}
                return countyName.lowercased().hasPrefix(character.lowercased())
            case let city as TRCity:
                guard let cityName = city.sehirAd else { return false}
                return cityName.lowercased().hasPrefix(character.lowercased())
            case let county as TRCounty:
                guard let countyName = county.ilceAd else { return false}
                return countyName.lowercased().hasPrefix(character.lowercased())
            default:
                return false
            }
        }
        
        self.citiesCounties.onNext(filteredCitiesCounties)
        
    }
    
    //MARK: - Set Loading Animate State
    private func setLoadingAnimateState(fetchingCities: Bool? = nil, fetchedCities: Void? = nil, errorMsg: String? = nil) {
        if let fetchingCities {
            self.fetchingCities.onNext(fetchingCities)
        } else if let fetchedCities {
            self.fetchedCities.onNext(fetchedCities)
        } else if let errorMsg {
            self.errorMsg.onNext(errorMsg)
        }
    }
    
    
    
}
