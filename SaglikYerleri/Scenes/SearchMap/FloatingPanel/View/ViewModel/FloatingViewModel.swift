//
//  FloatingViewModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 5.05.2023.
//

import RxSwift
import UIKit
import CoreData

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
    
    
    //MARK: - Save to Core Data Calls
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let savePharmacyCellDataToCoreData = PublishSubject<PharmacyCellDataProtocol>()
    let saveSharedCell1DataToCoreData = PublishSubject<SharedCell1DataProtocol>()
    let saveSharedCell2DataToCoreData = PublishSubject<SharedCell2DataProtocol>()
    
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
        self.subscribeToCellSelections()
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

//MARK: - Save data to core data
extension FloatingViewModel {
    private func subscribeToCellSelections() {
        self.savePharmacyCellDataToCoreData.subscribe(onNext: { [weak self] pharmacyCellDataProtocol in
            guard let self else { return }
            
            // Check for duplicate data
            let fetchRequest: NSFetchRequest<PharmacyCellData> = PharmacyCellData.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name == %@", pharmacyCellDataProtocol.pharmacyName)
            let fetchResult = try? context.fetch(fetchRequest)
            
            if let existingData = fetchResult?.first {
                // Update existing data
                existingData.imageBackgroundColor = pharmacyCellDataProtocol.pharmacyImageBackgroundColor
                existingData.image = pharmacyCellDataProtocol.pharmacyImage
                existingData.address = pharmacyCellDataProtocol.pharmacyAddress
                existingData.directions = pharmacyCellDataProtocol.pharmacyDirections
                existingData.phone1 = pharmacyCellDataProtocol.pharmacyPhone1
                existingData.phone2 = pharmacyCellDataProtocol.pharmacyPhone2
                existingData.lat = pharmacyCellDataProtocol.pharmacyLat
                existingData.lng = pharmacyCellDataProtocol.pharmacyLng
            } else {
                // Create a CellDataModel context
                let cellData = CellData(context: context)
                
                // create SharedCell1 Data object
                let pharmacyCellData = PharmacyCellData(context: context)
                
                pharmacyCellData.imageBackgroundColor = pharmacyCellDataProtocol.pharmacyImageBackgroundColor
                pharmacyCellData.image = pharmacyCellDataProtocol.pharmacyImage
                pharmacyCellData.name = pharmacyCellDataProtocol.pharmacyName
                pharmacyCellData.address = pharmacyCellDataProtocol.pharmacyAddress
                pharmacyCellData.directions = pharmacyCellDataProtocol.pharmacyDirections
                pharmacyCellData.phone1 = pharmacyCellDataProtocol.pharmacyPhone1
                pharmacyCellData.phone2 = pharmacyCellDataProtocol.pharmacyPhone2
                pharmacyCellData.lat = pharmacyCellDataProtocol.pharmacyLat
                pharmacyCellData.lng = pharmacyCellDataProtocol.pharmacyLng
                
                // Add Shared1 Cell Datas to cell data
                cellData.addToPharmayCells(pharmacyCellData)
            }
            
            
            // save the data
            do {
                try self.context.save()
            } catch {
                print("Did occur error while saving data PharmacyCellData to Core data error: !!!!!\(error.localizedDescription)!!!!!")
            }
            
            // can do re - fetch data now
        }).disposed(by: disposeBag)
        
        self.saveSharedCell1DataToCoreData.subscribe(onNext: { [weak self] sharedCell1DataProtocol in
            guard let self else { return }
            // save shared cell1 data
            
            // Check for duplicate data
            let fetchRequest: NSFetchRequest<SharedCell1Data> = SharedCell1Data.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name == %@", sharedCell1DataProtocol.sharedCell1Name)
            let fetchResult = try? context.fetch(fetchRequest)
            
            if let existingData = fetchResult?.first {
                // Update existing data
                existingData.imageBackroundColor = sharedCell1DataProtocol.sharedCell1ImageBackgroundColor
                existingData.image = sharedCell1DataProtocol.sharedCell1Image
                existingData.address = sharedCell1DataProtocol.sharedCell1Address
                existingData.phone = sharedCell1DataProtocol.sharedCell1Phone
                existingData.email = sharedCell1DataProtocol.sharedCell1Email
                existingData.lat = sharedCell1DataProtocol.sharedCell1Lat
                existingData.lng = sharedCell1DataProtocol.sharedCell1Lng
            } else {
                // Create a CellDataModel context
                let cellData = CellData(context: context)
                
                // create SharedCell1 Data object
                let sharedCell1Data = SharedCell1Data(context: context)
                
                sharedCell1Data.imageBackroundColor = sharedCell1DataProtocol.sharedCell1ImageBackgroundColor
                sharedCell1Data.image = sharedCell1DataProtocol.sharedCell1Image
                sharedCell1Data.name = sharedCell1DataProtocol.sharedCell1Name
                sharedCell1Data.address = sharedCell1DataProtocol.sharedCell1Address
                sharedCell1Data.phone = sharedCell1DataProtocol.sharedCell1Phone
                sharedCell1Data.email = sharedCell1DataProtocol.sharedCell1Email
                sharedCell1Data.lat = sharedCell1DataProtocol.sharedCell1Lat
                sharedCell1Data.lng = sharedCell1DataProtocol.sharedCell1Lng
                
                // Add Shared1 Cell Datas to cell data
                cellData.addToShared1Cells(sharedCell1Data)
            }
            
            // save the data
            do {
                try self.context.save()
            } catch {
                print("Did occur error while saving data Shared1CellData to Core data error: !!!!!\(error.localizedDescription)!!!!!")
            }
            
        }).disposed(by: disposeBag)
        
        self.saveSharedCell2DataToCoreData.subscribe(onNext: { [weak self] sharedCell2DataProtocol in
            guard let self else { return }
            // save shared cell2 data
            
            // Check for duplicate data
            let fetchRequest: NSFetchRequest<SharedCell2Data> = SharedCell2Data.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name == %@", sharedCell2DataProtocol.sharedCell2Name )
            let fetchResult = try? context.fetch(fetchRequest)
            
            
            if let existingData = fetchResult?.first {
                // Update existing data
                existingData.imageBackgroundColor = sharedCell2DataProtocol.sharedCell2ImageBackgroundColor
                existingData.image = sharedCell2DataProtocol.sharedCell2Image
                existingData.street = sharedCell2DataProtocol.sharedCell2Street
                existingData.phone = sharedCell2DataProtocol.sharedCell2Phone
                existingData.webSite = sharedCell2DataProtocol.sharedCell2WebSite
                existingData.lat = sharedCell2DataProtocol.sharedCell2Lat
                existingData.lng = sharedCell2DataProtocol.sharedCell2Lng
            } else {
                // Add Shared2Cell Data to cell data
                // Create a CellDataModel context
                let cellData = CellData(context: context)
                
                //  Create SharedCell2Data object
                let sharedCell2Data = SharedCell2Data(context: context)
                
                sharedCell2Data.imageBackgroundColor = sharedCell2DataProtocol.sharedCell2ImageBackgroundColor
                sharedCell2Data.image = sharedCell2DataProtocol.sharedCell2Image
                sharedCell2Data.name = sharedCell2DataProtocol.sharedCell2Name
                sharedCell2Data.street = sharedCell2DataProtocol.sharedCell2Street
                sharedCell2Data.phone = sharedCell2DataProtocol.sharedCell2Phone
                sharedCell2Data.webSite = sharedCell2DataProtocol.sharedCell2WebSite
                sharedCell2Data.lat = sharedCell2DataProtocol.sharedCell2Lat
                sharedCell2Data.lng = sharedCell2DataProtocol.sharedCell2Lng
                
                cellData.addToShared2Cells(sharedCell2Data)
            }
            
            
            // save the data
            do {
                try self.context.save()
            } catch {
                print("Did occur error while saving data Shared2CellData to Core data error: !!!!!\(error.localizedDescription)!!!!!")
            }
            
        }).disposed(by: disposeBag)
    }
    
    
    
}

