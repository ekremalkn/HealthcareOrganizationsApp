//
//  FloatingViewModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 5.05.2023.
//

import Foundation
import RxSwift

final class FloatingViewModel {
    
    //MARK: - Category Type
    let categoryType: NetworkConstants

    //MARK: - Variables
    let citySlug: String?
    let countySlug: String?

    let organizations = PublishSubject<[OrganizationModel]>()

    //MARK: - Dispose Bag
    private let disposeBag = DisposeBag()

    //MARK: - Init Methods
    init(categoryType: NetworkConstants, citySlug: String, countySlug: String) {
        self.categoryType = categoryType
        self.citySlug = citySlug
        self.countySlug = countySlug
    }

    
    //MARK: - Fetch Organizations
    func fetchOrganizations() {
        guard let citySlug, let countySlug else { return }
        switch categoryType {
        case .hospitals:
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (hospitalModel: Event<HospitalModel?>) in
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
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (healthCenterModel: Event<HealthCenterModel?>) in
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
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (dentalCenterModel: Event<DentalCenterModel?>) in
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
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (pharmacyModel: Event<PharmacyModel?>) in
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
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (medicalLaboratoryModel: Event<MedicalLaboratoryModel?>) in
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
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (radiologyCenterModel: Event<RadiologyCenterModel?>) in
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
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (animalHospitalModel: Event<AnimalHospitalModel?>) in
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
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (psychologistCenterModel: Event<PsychologyCenterModel?>) in
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
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (gynecologyCenterModel: Event<GynecologyCenterModel?>) in
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
        case .opticCenters:
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (optikCenterModel: Event<OptikCenterModel?>) in
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
        case .privateDentalCenters:
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (privateDentalCenterModel: Event<PrivateDentalCenterModel?>) in
                switch privateDentalCenterModel {
                case .next(let privateDentalCenters):
                    guard let privateDentalCenters = privateDentalCenters?.data else { return }
                    self?.organizations.onNext(privateDentalCenters)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .spaCenters:
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (spaCenterModel: Event<SpaCenterModel?>) in
                switch spaCenterModel {
                case .next(let spaCenters):
                    guard let spaCenters = spaCenters?.data else { return }
                    self?.organizations.onNext(spaCenters)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .dialysisCenters:
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (dialysisCenterModel: Event<DialysisCenterModel?>) in
                switch dialysisCenterModel {
                case .next(let dialysisCenters):
                    guard let dialysisCenters = dialysisCenters?.data else { return }
                    self?.organizations.onNext(dialysisCenters)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .emergencyCenters:
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (emergencyCenterModel: Event<EmergencyCenterModel?>) in
                switch emergencyCenterModel {
                case .next(let emergencyCenters):
                    guard let emergencyCenters = emergencyCenters?.data else { return }
                    self?.organizations.onNext(emergencyCenters)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .medicalShopCenters:
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (medicalCenterShopModel: Event<MedicalShopCenterModel?>) in
                switch medicalCenterShopModel {
                case .next(let medicalCenters):
                    guard let medicalCenters = medicalCenters?.data else { return }
                    self?.organizations.onNext(medicalCenters)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .physiotheraphyCenters:
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (physiotheraphyCenterModel: Event<PhysiotheraphyCenterModel?>) in
                switch physiotheraphyCenterModel {
                case .next(let physiotheraphyCenters):
                    guard let physiotheraphyCenters = physiotheraphyCenters?.data else { return }
                    self?.organizations.onNext(physiotheraphyCenters)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        }
    }

}
