//
//  FloatingViewModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 5.05.2023.
//

import RxSwift

final class FloatingViewModel {
    deinit {
        print("deinit FloatingViewModel")
    }
    //MARK: - Network Service
    var networkSerivce: OrganizationsService?

    //MARK: - Category Type
    let categoryType: NetworkConstants?
    
    //MARK: - Variables
    let citySlug: String?
    let countySlug: String?
    let cityName: String?
    let countyName: String?
    var numberOfItems: Int?
    
    let fetchingOrganizations = PublishSubject<Bool>()
    let fetchedOrganizations = PublishSubject<Void>()
    let errorMsg = PublishSubject<String>()
    
    let pharmacyCellData = PublishSubject<[PharmacyCellDataProtocol]>()
    let sharedCell1Data = PublishSubject<[SharedCell1DataProtocol]>()
    let sharedCell2Data = PublishSubject<[SharedCell2DataProtocol]>()
 
    
    //MARK: - TableView Observables


    //MARK: - Dispose Bag
    private let disposeBag = DisposeBag()
    
    //MARK: - Init Methods
    init(categoryType: NetworkConstants, networkService: OrganizationsService, citySlug: String, countySlug: String, cityName: String, countyName: String) {
        self.categoryType = categoryType
        self.networkSerivce = networkService
        self.citySlug = citySlug
        self.countySlug = countySlug
        self.cityName = cityName
        self.countyName = countyName
    }
}
 

//MARK: - Network Process
extension FloatingViewModel {
    //MARK: - Fetch Organizations
    func fetchOrganizations() {
        self.setLoadingAnimateState(fetchingOrganizations: true)
        guard let categoryType, let networkSerivce, let citySlug, let countySlug else { return }
        switch categoryType {
        case .hospitals:
            networkSerivce.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (hospitalModel: Event<HospitalModel?>) in
                switch hospitalModel {
                case .next(let hospitalModel):
                    guard let hospitals = hospitalModel?.data else { return }
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: (), errorMsg: nil)
                    self?.numberOfItems = hospitals.count
                    self?.sharedCell1Data.onNext(hospitals)
                case .error(let error):
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: error.localizedDescription)
                case .completed:
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: nil)
                }
            }.disposed(by: disposeBag)
        case .healthCenters:
            networkSerivce.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (healthCenterModel: Event<HealthCenterModel?>) in
                switch healthCenterModel {
                case .next(let healthCenterModel):
                    guard let healthCenters = healthCenterModel?.data else { return }
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: (), errorMsg: nil)
                    self?.numberOfItems = healthCenters.count
                    self?.sharedCell1Data.onNext(healthCenters)
                case .error(let error):
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: error.localizedDescription)
                case .completed:
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: nil)
                }
            }.disposed(by: disposeBag)
        case .dentalCenters:
            networkSerivce.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (dentalCenterModel: Event<DentalCenterModel?>) in
                switch dentalCenterModel {
                case .next(let dentalCenterModel):
                    guard let dentalCenters = dentalCenterModel?.data else { return }
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: (), errorMsg: nil)
                    self?.numberOfItems = dentalCenters.count
                    self?.sharedCell2Data.onNext(dentalCenters)
                case .error(let error):
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: error.localizedDescription)
                case .completed:
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: nil)
                }
            }.disposed(by: disposeBag)
        case .pharmacy:
            networkSerivce.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (pharmacyModel: Event<PharmacyModel?>) in
                switch pharmacyModel {
                case .next(let pharmacyModel):
                    guard let pharmacies = pharmacyModel?.data else { return }
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: (), errorMsg: nil)
                    self?.numberOfItems = pharmacies.count
                    self?.pharmacyCellData.onNext(pharmacies)
                case .error(let error):
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: error.localizedDescription)
                case .completed:
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: nil)
                }
            }.disposed(by: disposeBag)
        case .medicalLaboratories:
            networkSerivce.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (medicalLaboratoryModel: Event<MedicalLaboratoryModel?>) in
                switch medicalLaboratoryModel {
                case .next(let medicalLaboratoryModel):
                    guard let medicalLaboratories = medicalLaboratoryModel?.data else { return }
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: (), errorMsg: nil)
                    self?.numberOfItems = medicalLaboratories.count
                    self?.sharedCell1Data.onNext(medicalLaboratories)
                case .error(let error):
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: error.localizedDescription)
                case .completed:
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: nil)
                }
            }.disposed(by: disposeBag)
        case .radiologyCenters:
            networkSerivce.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (radiologyCenterModel: Event<RadiologyCenterModel?>) in
                switch radiologyCenterModel {
                case .next(let radiologyCenterModel):
                    guard let radiologyCenters = radiologyCenterModel?.data else { return }
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: (), errorMsg: nil)
                    self?.numberOfItems = radiologyCenters.count
                    self?.sharedCell1Data.onNext(radiologyCenters)
                case .error(let error):
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: error.localizedDescription)
                case .completed:
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: nil)
                }
            }.disposed(by: disposeBag)
        case .animalHospitals:
            networkSerivce.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (animalHospitalModel: Event<AnimalHospitalModel?>) in
                switch animalHospitalModel {
                case .next(let animalHospitalModel):
                    guard let animalHospitals = animalHospitalModel?.data else { return }
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: (), errorMsg: nil)
                    self?.numberOfItems = animalHospitals.count
                    self?.sharedCell2Data.onNext(animalHospitals)
                case .error(let error):
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: error.localizedDescription)
                case .completed:
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: nil)
                }
            }.disposed(by: disposeBag)
        case .psychologistCenters:
            networkSerivce.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (psychologistCenterModel: Event<PsychologyCenterModel?>) in
                switch psychologistCenterModel {
                case .next(let psychologistCenterModel):
                    guard let psychologistCenters = psychologistCenterModel?.data else { return }
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: (), errorMsg: nil)
                    self?.numberOfItems = psychologistCenters.count
                    self?.sharedCell2Data.onNext(psychologistCenters)
                case .error(let error):
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: error.localizedDescription)
                case .completed:
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: nil)
                }
            }.disposed(by: disposeBag)
        case .gynecologyCenters:
            networkSerivce.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (gynecologyCenterModel: Event<GynecologyCenterModel?>) in
                switch gynecologyCenterModel {
                case .next(let gynecologyCenterModel):
                    guard let gynecologyCenters = gynecologyCenterModel?.data else { return }
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: (), errorMsg: nil)
                    self?.numberOfItems = gynecologyCenters.count
                    self?.sharedCell2Data.onNext(gynecologyCenters)
                case .error(let error):
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: error.localizedDescription)
                case .completed:
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: nil)
                }
            }.disposed(by: disposeBag)
        case .opticCenters:
            networkSerivce.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (optikCenterModel: Event<OptikCenterModel?>) in
                switch optikCenterModel {
                case .next(let optikCenterModel):
                    guard let optikCenters = optikCenterModel?.data else { return }
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: (), errorMsg: nil)
                    self?.numberOfItems = optikCenters.count
                    self?.sharedCell2Data.onNext(optikCenters)
                case .error(let error):
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: error.localizedDescription)
                case .completed:
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: nil)
                }
            }.disposed(by: disposeBag)
        case .privateDentalCenters:
            networkSerivce.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (privateDentalCenterModel: Event<PrivateDentalCenterModel?>) in
                switch privateDentalCenterModel {
                case .next(let privateDentalCenterModel):
                    guard let privateDentalCenters = privateDentalCenterModel?.data else { return }
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: (), errorMsg: nil)
                    self?.numberOfItems = privateDentalCenters.count
                    self?.sharedCell2Data.onNext(privateDentalCenters)
                case .error(let error):
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: error.localizedDescription)
                case .completed:
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: nil)
                }
            }.disposed(by: disposeBag)
        case .spaCenters:
            networkSerivce.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (spaCenterModel: Event<SpaCenterModel?>) in
                switch spaCenterModel {
                case .next(let spaCenterModel):
                    guard let spaCenters = spaCenterModel?.data else { return }
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: (), errorMsg: nil)
                    self?.numberOfItems = spaCenters.count
                    self?.sharedCell2Data.onNext(spaCenters)
                case .error(let error):
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: error.localizedDescription)
                case .completed:
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: nil)
                }
            }.disposed(by: disposeBag)
        case .dialysisCenters:
            networkSerivce.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (dialysisCenterModel: Event<DialysisCenterModel?>) in
                switch dialysisCenterModel {
                case .next(let dialysisCenterModel):
                    guard let dialysisCenters = dialysisCenterModel?.data else { return }
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: (), errorMsg: nil)
                    self?.numberOfItems = dialysisCenters.count
                    self?.sharedCell2Data.onNext(dialysisCenters)
                case .error(let error):
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: error.localizedDescription)
                case .completed:
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: nil)
                }
            }.disposed(by: disposeBag)
        case .emergencyCenters:
            networkSerivce.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (emergencyCenterModel: Event<EmergencyCenterModel?>) in
                switch emergencyCenterModel {
                case .next(let emergencyCenterModel):
                    guard let emergencyCenters = emergencyCenterModel?.data else { return }
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: (), errorMsg: nil)
                    self?.numberOfItems = emergencyCenters.count
                    self?.sharedCell2Data.onNext(emergencyCenters)
                case .error(let error):
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: error.localizedDescription)
                case .completed:
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: nil)
                }
            }.disposed(by: disposeBag)
        case .medicalShopCenters:
            networkSerivce.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (medicalCenterShopModel: Event<MedicalShopCenterModel?>) in
                switch medicalCenterShopModel {
                case .next(let medicalCenterShopModel):
                    guard let medicalShopCenters = medicalCenterShopModel?.data else { return }
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: (), errorMsg: nil)
                    self?.numberOfItems = medicalShopCenters.count
                    self?.sharedCell2Data.onNext(medicalShopCenters)
                case .error(let error):
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: error.localizedDescription)
                case .completed:
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: nil)
                }
            }.disposed(by: disposeBag)
        case .physiotheraphyCenters:
            networkSerivce.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (physiotheraphyCenterModel: Event<PhysiotheraphyCenterModel?>) in
                switch physiotheraphyCenterModel {
                case .next(let physiotheraphyCenterModel):
                    guard let physiotheraphyCenters = physiotheraphyCenterModel?.data else { return }
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: (), errorMsg: nil)
                    self?.numberOfItems = physiotheraphyCenters.count
                    self?.sharedCell2Data.onNext(physiotheraphyCenters)
                case .error(let error):
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: error.localizedDescription)
                case .completed:
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: nil)
                }
            }.disposed(by: disposeBag)
        case .dutyPharmacy:
            networkSerivce.getHealthOrganizations(type: categoryType, city: citySlug, county: countySlug).subscribe { [weak self] (dutyPharmacyModel: Event<PharmacyModel?>) in
                switch dutyPharmacyModel {
                case .next(let dutyPharmacyModel):
                    guard let dutyPharmacies = dutyPharmacyModel?.data else { return }
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: (), errorMsg: nil)
                    self?.numberOfItems = dutyPharmacies.count
                    self?.pharmacyCellData.onNext(dutyPharmacies)
                case .error(let error):
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: error.localizedDescription)
                case .completed:
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: nil)
                }
            }.disposed(by: disposeBag)
        }
    }

}

//MARK: - Set Loading Animate State
extension FloatingViewModel {
    private func setLoadingAnimateState(fetchingOrganizations: Bool? = nil, fetchedOrganizations: Void? = nil, errorMsg: String? = nil) {
        if let fetching = fetchingOrganizations {
            self.fetchingOrganizations.onNext(fetching)
            
            if !fetching {
                if let fetched = fetchedOrganizations {
                    self.fetchedOrganizations.onNext(fetched)
                } else if let errorMsg = errorMsg {
                    self.errorMsg.onNext(errorMsg)
                }
            }
        }
        
    }
}

