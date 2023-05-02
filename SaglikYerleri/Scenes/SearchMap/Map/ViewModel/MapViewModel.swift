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
    let organizations = PublishSubject<[OrganizationModel]>()

    //MARK: - Dispose Bag
    private let disposeBag = DisposeBag()


    //MARK: - Init Methods
    init(categoryType: NetworkConstants) {
        self.categoryType = categoryType
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
                    print(pharmacies)
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
