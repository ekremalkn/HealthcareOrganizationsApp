//
//  MapViewModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 26.04.2023.
//

import Foundation
import RxSwift

final class MapViewModel {
    
    //MARK: - Category Type
    let categoryType: NetworkConstants?
        
    //MARK: - Variables
    let cities = PublishSubject<[CityModel]>()
    let counties = PublishSubject<[CountyModel]>()
    let organizations = PublishSubject<[OrganizationModel]>()

    //MARK: - Dispose Bag
    private let disposeBag = DisposeBag()


    //MARK: - Init Methods
    init(type: NetworkConstants) {
        self.categoryType = type
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
                    self?.counties.onNext(hospitalCounties)
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
                    self?.counties.onNext(healthCenterCounties)
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
                    self?.counties.onNext(dentalCenterCounties)
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
                    self?.counties.onNext(pharmacyCounties)
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
                    self?.counties.onNext(medicalLaboratoryCounties)
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
                    self?.counties.onNext(radiologyCenterCounties)
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
                    self?.counties.onNext(animalHospitalCounties)
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
                    self?.counties.onNext(psychologistCenterCounties)
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
                    self?.counties.onNext(gynecologyCenterCounties)
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
                    self?.counties.onNext(optikCenterCounties)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        }
    }
    
    //MARK: - Fetch Organizations
    func fetchOrganizations(city: String, county: String) {
        guard let categoryType else { return }
        
        switch categoryType {
        case .hospitals:
            NetworkService.shared.getHealthOrganizations(type: .hospitals, city: city, county: county).subscribe { [weak self] (hospitalModel: Event<HospitalModel?>) in
                switch hospitalModel {
                case .next(let hospitals):
                    guard let hospitals = hospitals?.data else { return }
                    self?.organizations.onNext(hospitals)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .healthCenters:
            NetworkService.shared.getHealthOrganizations(type: .healthCenters, city: city, county: county).subscribe { [weak self] (healthCenterModel: Event<HealthCenterModel?>) in
                switch healthCenterModel {
                case .next(let healthCenters):
                    guard let healthCenters = healthCenters?.data else { return }
                    self?.organizations.onNext(healthCenters)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .dentalCenters:
            NetworkService.shared.getHealthOrganizations(type: .dentalCenters, city: city, county: county).subscribe { [weak self] (dentalCenterModel: Event<DentalCenterModel?>) in
                switch dentalCenterModel {
                case .next(let dentalCenters):
                    guard let dentalCenters = dentalCenters?.data else { return }
                    self?.organizations.onNext(dentalCenters)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .pharmacy:
            NetworkService.shared.getHealthOrganizations(type: .pharmacy, city: city, county: county).subscribe { [weak self] (pharmacyModel: Event<PharmacyModel?>) in
                switch pharmacyModel {
                case .next(let pharmacies):
                    guard let pharmacies = pharmacies?.data else { return }
                    self?.organizations.onNext(pharmacies)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .medicalLaboratories:
            NetworkService.shared.getHealthOrganizations(type: .medicalLaboratories, city: city, county: county).subscribe { [weak self] (medicalLaboratoryModel: Event<MedicalLaboratoryModel?>) in
                switch medicalLaboratoryModel {
                case .next(let medicalLaboratories):
                    guard let medicalLaboratories = medicalLaboratories?.data else { return }
                    self?.organizations.onNext(medicalLaboratories)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .radiologyCenters:
            NetworkService.shared.getHealthOrganizations(type: .radiologyCenters, city: city, county: county).subscribe { [weak self] (radiologyCenterModel: Event<RadiologyCenterModel?>) in
                switch radiologyCenterModel {
                case .next(let radiologyCenters):
                    guard let radiologyCenters = radiologyCenters?.data else { return }
                    self?.organizations.onNext(radiologyCenters)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .animalHospitals:
            NetworkService.shared.getHealthOrganizations(type: .animalHospitals, city: city, county: county).subscribe { [weak self] (animalHospitalModel: Event<AnimalHospitalModel?>) in
                switch animalHospitalModel {
                case .next(let animalHospitals):
                    guard let animalHospitals = animalHospitals?.data else { return }
                    self?.organizations.onNext(animalHospitals)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .psychologistCenters:
            NetworkService.shared.getHealthOrganizations(type: .psychologistCenters, city: city, county: county).subscribe { [weak self] (psychologistCenterModel: Event<PsychologyCenterModel?>) in
                switch psychologistCenterModel {
                case .next(let psychologistCenters):
                    guard let psychologistCenters = psychologistCenters?.data else { return }
                    self?.organizations.onNext(psychologistCenters)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .gynecologyCenters:
            NetworkService.shared.getHealthOrganizations(type: .gynecologyCenters, city: city, county: county).subscribe { [weak self] (gynecologyCenterModel: Event<GynecologyCenterModel?>) in
                switch gynecologyCenterModel {
                case .next(let gynecologyCenters):
                    guard let gynecologyCenters = gynecologyCenters?.data else { return }
                    self?.organizations.onNext(gynecologyCenters)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .optikCenters:
            NetworkService.shared.getHealthOrganizations(type: .optikCenters, city: city, county: county).subscribe { [weak self] (optikCenterModel: Event<GynecologyCenterModel?>) in
                switch optikCenterModel {
                case .next(let optikCenters):
                    guard let optikCenters = optikCenters?.data else { return }
                    self?.organizations.onNext(optikCenters)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        }
    }
    
}
