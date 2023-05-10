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
    let categoryType: NetworkConstants?
    
    //MARK: - Variables
    let citySlug: String?
    let countySlug: String?
    let cityName: String?
    let countyName: String?
    var numberOfItems: Int?
    
    let pharmacies = PublishSubject<[Pharmacy]>()
    
    let healthCenters = PublishSubject<[HealthCenter]>()
    let hospitals = PublishSubject<[Hospital]>()
    let radiologyCenters = PublishSubject<[RadiologyCenter]>()
    let medicalLaboratories = PublishSubject<[MedicalLaboratory]>()
    
    let dentalCenters = PublishSubject<[DentalCenter]>()
    let animalHospitals = PublishSubject<[AnimalHospital]>()
    let psychologistCenters = PublishSubject<[PsychologistCenter]>()
    let gynecologyCenters = PublishSubject<[GynecologyCenter]>()
    let opticCenters = PublishSubject<[OptikCenter]>()
    let physiotheraphyCenters = PublishSubject<[PhysiotheraphyCenter]>()
    let dialysisCenters = PublishSubject<[DialysisCenter]>()
    let emergencyCenters = PublishSubject<[EmergencyCenter]>()
    let privateDentalCenters = PublishSubject<[PrivateDentalCenter]>()
    let medicalShopCenters = PublishSubject<[MedicalShopCenter]>()
    let spaCenters = PublishSubject<[SpaCenter]>()
    
    //MARK: - Dispose Bag
    private let disposeBag = DisposeBag()
    
    //MARK: - Init Methods
    init(categoryType: NetworkConstants, citySlug: String, countySlug: String, cityName: String, countyName: String) {
        self.categoryType = categoryType
        self.citySlug = citySlug
        self.countySlug = countySlug
        self.cityName = cityName
        self.countyName = countyName
    }
    
    deinit {
        print("floating viewmodel deinitr")
    }
    
    //MARK: - Fetch Organizations
    func fetchOrganizations() {
        guard let categoryType, let citySlug, let countySlug else { return }
        switch categoryType {
        case .hospitals:
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (hospitalModel: Event<HospitalModel?>) in
                switch hospitalModel {
                case .next(let hospitalModel):
                    guard let hospitals = hospitalModel?.data else { return }
                    self?.numberOfItems = hospitals.count
                    self?.hospitals.onNext(hospitals)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .healthCenters:
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (healthCenterModel: Event<HealthCenterModel?>) in
                switch healthCenterModel {
                case .next(let healthCenterModel):
                    guard let healthCenters = healthCenterModel?.data else { return }
                    self?.numberOfItems = healthCenters.count
                    self?.healthCenters.onNext(healthCenters)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .dentalCenters:
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (dentalCenterModel: Event<DentalCenterModel?>) in
                switch dentalCenterModel {
                case .next(let dentalCenterModel):
                    guard let dentalCenters = dentalCenterModel?.data else { return }
                    self?.numberOfItems = dentalCenters.count
                    self?.dentalCenters.onNext(dentalCenters)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .pharmacy:
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (pharmacyModel: Event<PharmacyModel?>) in
                switch pharmacyModel {
                case .next(let pharmacyModel):
                    guard let pharmacies = pharmacyModel?.data else { return }
                    self?.numberOfItems = pharmacies.count
                    self?.pharmacies.onNext(pharmacies)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .medicalLaboratories:
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (medicalLaboratoryModel: Event<MedicalLaboratoryModel?>) in
                switch medicalLaboratoryModel {
                case .next(let medicalLaboratoryModel):
                    guard let medicalLaboratories = medicalLaboratoryModel?.data else { return }
                    self?.numberOfItems = medicalLaboratories.count
                    self?.medicalLaboratories.onNext(medicalLaboratories)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .radiologyCenters:
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (radiologyCenterModel: Event<RadiologyCenterModel?>) in
                switch radiologyCenterModel {
                case .next(let radiologyCenterModel):
                    guard let radiologyCenters = radiologyCenterModel?.data else { return }
                    self?.numberOfItems = radiologyCenters.count
                    self?.radiologyCenters.onNext(radiologyCenters)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .animalHospitals:
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (animalHospitalModel: Event<AnimalHospitalModel?>) in
                switch animalHospitalModel {
                case .next(let animalHospitalModel):
                    guard let animalHospitals = animalHospitalModel?.data else { return }
                    self?.numberOfItems = animalHospitals.count
                    self?.animalHospitals.onNext(animalHospitals)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .psychologistCenters:
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (psychologistCenterModel: Event<PsychologyCenterModel?>) in
                switch psychologistCenterModel {
                case .next(let psychologistCenterModel):
                    guard let psychologistCenters = psychologistCenterModel?.data else { return }
                    self?.numberOfItems = psychologistCenters.count
                    self?.psychologistCenters.onNext(psychologistCenters)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .gynecologyCenters:
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (gynecologyCenterModel: Event<GynecologyCenterModel?>) in
                switch gynecologyCenterModel {
                case .next(let gynecologyCenterModel):
                    guard let gynecologyCenters = gynecologyCenterModel?.data else { return }
                    self?.numberOfItems = gynecologyCenters.count
                    self?.gynecologyCenters.onNext(gynecologyCenters)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .opticCenters:
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (optikCenterModel: Event<OptikCenterModel?>) in
                switch optikCenterModel {
                case .next(let optikCenterModel):
                    guard let optikCenters = optikCenterModel?.data else { return }
                    self?.numberOfItems = optikCenters.count
                    self?.opticCenters.onNext(optikCenters)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .privateDentalCenters:
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (privateDentalCenterModel: Event<PrivateDentalCenterModel?>) in
                switch privateDentalCenterModel {
                case .next(let privateDentalCenterModel):
                    guard let privateDentalCenters = privateDentalCenterModel?.data else { return }
                    self?.numberOfItems = privateDentalCenters.count
                    self?.privateDentalCenters.onNext(privateDentalCenters)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .spaCenters:
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (spaCenterModel: Event<SpaCenterModel?>) in
                switch spaCenterModel {
                case .next(let spaCenterModel):
                    guard let spaCenters = spaCenterModel?.data else { return }
                    self?.numberOfItems = spaCenters.count
                    self?.spaCenters.onNext(spaCenters)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .dialysisCenters:
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (dialysisCenterModel: Event<DialysisCenterModel?>) in
                switch dialysisCenterModel {
                case .next(let dialysisCenterModel):
                    guard let dialysisCenters = dialysisCenterModel?.data else { return }
                    self?.numberOfItems = dialysisCenters.count
                    self?.dialysisCenters.onNext(dialysisCenters)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .emergencyCenters:
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (emergencyCenterModel: Event<EmergencyCenterModel?>) in
                switch emergencyCenterModel {
                case .next(let emergencyCenterModel):
                    guard let emergencyCenters = emergencyCenterModel?.data else { return }
                    self?.numberOfItems = emergencyCenters.count
                    self?.emergencyCenters.onNext(emergencyCenters)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .medicalShopCenters:
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (medicalCenterShopModel: Event<MedicalShopCenterModel?>) in
                switch medicalCenterShopModel {
                case .next(let medicalCenterShopModel):
                    guard let medicalShopCenters = medicalCenterShopModel?.data else { return }
                    self?.numberOfItems = medicalShopCenters.count
                    self?.medicalShopCenters.onNext(medicalShopCenters)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .physiotheraphyCenters:
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (physiotheraphyCenterModel: Event<PhysiotheraphyCenterModel?>) in
                switch physiotheraphyCenterModel {
                case .next(let physiotheraphyCenterModel):
                    guard let physiotheraphyCenters = physiotheraphyCenterModel?.data else { return }
                    self?.numberOfItems = physiotheraphyCenters.count
                    self?.physiotheraphyCenters.onNext(physiotheraphyCenters)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        case .dutyPharmacy:
            NetworkService.shared.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { (dutyPharmacyModel: Event<PharmacyModel?>) in
                switch dutyPharmacyModel {
                case .next(let dutyPharmacyModel):
                    guard let dutyPharmacies = dutyPharmacyModel?.data else { return }
                    self.numberOfItems = dutyPharmacies.count
                    self.pharmacies.onNext(dutyPharmacies)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("success")
                }
            }.disposed(by: disposeBag)
        }
    }
    
}
