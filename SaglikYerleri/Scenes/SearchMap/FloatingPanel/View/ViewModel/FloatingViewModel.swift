//
//  FloatingViewModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 5.05.2023.
//

import Foundation
import RxSwift
import UIKit

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
    
    //MARK: - TableView Observables
    let configurePharmacyCell = PublishSubject<(PharmacyCell, PharmacyCellDataProtocol)>()
    let configureSharedCell1 = PublishSubject<(SharedCell1, SharedCell1DataProtocol)>()
    let configureSharedCell2 = PublishSubject<(SharedCell2, SharedCell2DataProtocol)>()
    let tableViewCellSelected = PublishSubject<(UITableView, at: IndexPath)>()
    var selectedCellType: SelectedCellType?
    var selectedCellIndexPath: IndexPath?
    var isExpanded: Bool = false


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

//MARK: - View Process
extension FloatingViewModel {
     func configureTableView(tableView: UITableView, floatingController: FloatingController ) {
        guard let categoryType else { return }
        // Bind data
        switch categoryType {
        case .pharmacy:
            pharmacies.bind(to: tableView.rx.items(cellIdentifier: PharmacyCell.identifier, cellType: PharmacyCell.self)) { [weak self] index, pharmacy, cell in
                self?.selectedCellType = .pharmacyCell
                self?.configurePharmacyCell.onNext((cell, pharmacy))
            }.disposed(by: disposeBag)
        case .medicalLaboratories:
            medicalLaboratories.bind(to: tableView.rx.items(cellIdentifier: SharedCell1.identifier, cellType: SharedCell1.self)) { [weak self] index, medicalLaboratory, cell in
                self?.selectedCellType = .sharedCell1
                self?.configureSharedCell1.onNext((cell, medicalLaboratory))
            }.disposed(by: disposeBag)
        case .radiologyCenters:
           radiologyCenters.bind(to: tableView.rx.items(cellIdentifier: SharedCell1.identifier, cellType: SharedCell1.self)) { [weak self] index, radiologyCenter, cell in
                self?.selectedCellType = .sharedCell1
               self?.configureSharedCell1.onNext((cell, radiologyCenter))
            }.disposed(by: disposeBag)
        case .healthCenters:
            healthCenters.bind(to: tableView.rx.items(cellIdentifier: SharedCell1.identifier, cellType: SharedCell1.self)) { [weak self] index, healthCenter, cell in
                self?.selectedCellType = .sharedCell1
                self?.configureSharedCell1.onNext((cell, healthCenter))
            }.disposed(by: disposeBag)
        case .hospitals:
            hospitals.bind(to: tableView.rx.items(cellIdentifier: SharedCell1.identifier, cellType: SharedCell1.self)) { [weak self] index, hospital, cell in
                self?.selectedCellType = .sharedCell1
                self?.configureSharedCell1.onNext((cell, hospital))
            }.disposed(by: disposeBag)
        case .dentalCenters:
            dentalCenters.bind(to: tableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { [weak self] index, dentalCenter, cell in
                self?.selectedCellType = .sharedCell2
                self?.configureSharedCell2.onNext((cell, dentalCenter))
            }.disposed(by: disposeBag)
        case .privateDentalCenters:
            privateDentalCenters.bind(to: tableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { [weak self] index, privateDentalCenter, cell in
                self?.selectedCellType = .sharedCell2
                self?.configureSharedCell2.onNext((cell, privateDentalCenter))
            }.disposed(by: disposeBag)
        case .spaCenters:
            spaCenters.bind(to: tableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { [weak self] index, spaCenter, cell in
                self?.selectedCellType = .sharedCell2
                self?.configureSharedCell2.onNext((cell, spaCenter))
            }.disposed(by: disposeBag)
        case .psychologistCenters:
            psychologistCenters.bind(to: tableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { [weak self] index, psychologistCenter, cell in
                self?.selectedCellType = .sharedCell2
                self?.configureSharedCell2.onNext((cell, psychologistCenter))
            }.disposed(by: disposeBag)
        case .gynecologyCenters:
            dentalCenters.bind(to: tableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { [weak self] index, gynecologyCenter, cell in
                self?.selectedCellType = .sharedCell2
                self?.configureSharedCell2.onNext((cell, gynecologyCenter))
            }.disposed(by: disposeBag)
        case .opticCenters:
            opticCenters.bind(to: tableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { [weak self] index, opticCenter, cell in
                self?.selectedCellType = .sharedCell2
                self?.configureSharedCell2.onNext((cell, opticCenter))
            }.disposed(by: disposeBag)
        case .animalHospitals:
            animalHospitals.bind(to: tableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { [weak self] index, animalHospital, cell in
                self?.selectedCellType = .sharedCell2
                self?.configureSharedCell2.onNext((cell, animalHospital))
            }.disposed(by: disposeBag)
        case .dialysisCenters:
            dialysisCenters.bind(to: tableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { [weak self] index, dialysisCenter, cell in
                self?.selectedCellType = .sharedCell2
                self?.configureSharedCell2.onNext((cell, dialysisCenter))
            }.disposed(by: disposeBag)
        case .emergencyCenters:
            emergencyCenters.bind(to: tableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { [weak self] index, emergencyCenter, cell in
                self?.selectedCellType = .sharedCell2
                self?.configureSharedCell2.onNext((cell, emergencyCenter))
            }.disposed(by: disposeBag)
        case .medicalShopCenters:
            medicalShopCenters.bind(to: tableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { [weak self] index, medicalShopCenter, cell in
                self?.selectedCellType = .sharedCell2
                self?.configureSharedCell2.onNext((cell, medicalShopCenter))
            }.disposed(by: disposeBag)
        case .physiotheraphyCenters:
            physiotheraphyCenters.bind(to: tableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { [weak self] index, physiotheraphyCenter, cell in
                self?.selectedCellType = .sharedCell2
                self?.configureSharedCell2.onNext((cell, physiotheraphyCenter))
            }.disposed(by: disposeBag)
        case .dutyPharmacy:
            pharmacies.bind(to: tableView.rx.items(cellIdentifier: PharmacyCell.identifier, cellType: PharmacyCell.self)) { [weak self] index, pharmacy, cell in
                self?.selectedCellType = .pharmacyCell
                self?.configurePharmacyCell.onNext((cell, pharmacy))
            }.disposed(by: disposeBag)
        }
        
        // Fetch Organizations
        fetchOrganizations()
        
        tableView.rx.itemSelected.subscribe { [weak self] indexPath in
            // Floating controllara cellselected ekle bunu içine at
            self?.tableViewCellSelected.onNext((tableView, at: indexPath))
            
            
        }.disposed(by: disposeBag)
        // Set delegate for TableView Cell Height / Header Height
        tableView.rx.setDelegate(floatingController).disposed(by: disposeBag)
        
    }
    
    func heightForRowAt(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard categoryType != nil else { return CGFloat() }
        guard let selectedCellType else { return 96 }
        if let selectedCellIndexPath {
            if selectedCellIndexPath == indexPath {
                switch selectedCellType {
                case .pharmacyCell:
                    return isExpanded ? calculateCellHeight(tableView: tableView, at: indexPath) : 96
                case .sharedCell1:
                    return isExpanded ? calculateCellHeight(tableView: tableView, at: indexPath) : 96
                case .sharedCell2:
                    return isExpanded ? calculateCellHeight(tableView: tableView, at: indexPath) : 96
                }
                
            }
        }
        return 96
    }
    
    private func calculateCellHeight(tableView: UITableView ,at indexPath: IndexPath) -> CGFloat {
        guard let selectedCellType else { return 100 }
        switch selectedCellType {
        case .pharmacyCell:
            var totalHeight: CGFloat = 81 // UI öğeleri arasındaki toplam boşluk miktarı
            guard let cell = tableView.cellForRow(at: indexPath) as? PharmacyCell else { return 100 }
            totalHeight += cell.nameLabel.frame.height
            totalHeight += cell.addressLabel.frame.height
            if cell.directionsLabel.text == "" || cell.directionsLabel.text == nil {
                print(cell.directionsLabel.font.lineHeight)
                totalHeight -= cell.directionsLabel.font.lineHeight
            } else {
                totalHeight += cell.directionsLabel.frame.height
            }
            totalHeight += cell.buttonStackView.frame.height
            let minimumHeight: CGFloat = 96
            return max(totalHeight, minimumHeight)
        case .sharedCell1:
            var totalHeight: CGFloat = 76 // UI öğeleri arasındaki toplam boşluk miktarı
            guard let cell = tableView.cellForRow(at: indexPath) as? SharedCell1 else { return 100 }
            totalHeight += cell.nameLabel.frame.height
            totalHeight += cell.addressLabel.frame.height
            totalHeight += cell.buttonStackView.frame.height

            let minimumHeight: CGFloat = 96
                    
            return max(totalHeight, minimumHeight)
        case .sharedCell2:
            var totalHeight: CGFloat = 76 // UI öğeleri arasındaki toplam boşluk miktarı
            guard let cell = tableView.cellForRow(at: indexPath) as? SharedCell2 else { return 100 }
            totalHeight += cell.nameLabel.frame.height
            totalHeight += cell.streetLabel.frame.height
            totalHeight += cell.buttonStackView.frame.height
            let minimumHeight: CGFloat = 96
                    
            return max(totalHeight, minimumHeight)
        }
       
    }
    
    func viewForHeaderInSection(tableHeaderView: PlacesTableHeaderView) -> UIView? {
        guard let numberOfItems = numberOfItems ,let cityName = cityName, let countyName = countyName else { return UIView() }
        tableHeaderView.configure(with: numberOfItems, cityName: cityName, countyName: countyName)
        
        return tableHeaderView
    }
    
    //MARK: - Expand cell When Selected
    func whenCellSelected(_ tableView: UITableView, indexPath: IndexPath, completion: @escaping (UITableView) -> Void) {
        self.selectedCellIndexPath = indexPath
        self.cellForRow(tableView, at: indexPath) {
            completion(tableView)
        }
        
        
    }
    
    private func cellForRow(_ tableView: UITableView, at indexPath: IndexPath, completion: @escaping () -> Void) {
        guard let selectedCellType else { return }
        switch selectedCellType {
        case .pharmacyCell:
            self.checkIfSelectedCellPharmacyCell(tableView, at: indexPath, selectedCellType: selectedCellType) {
                completion()
            }
        case .sharedCell1:
            self.checkIfSelectedCellSharedCell1(tableView, at: indexPath, selectedCellType: selectedCellType) {
                completion()
            }
        case .sharedCell2:
            self.checkIfSelectedCellSharedCell2(tableView, at: indexPath, selectedCellType: selectedCellType) {
                completion()
            }

        }
    }
    
    private func checkIfSelectedCellPharmacyCell(_ tableView: UITableView, at indexPath: IndexPath, selectedCellType: SelectedCellType, completion: @escaping () -> Void) {
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? PharmacyCell else { return }
        tableView.visibleCells.forEach { [weak self] cell in
            guard let self else { return }
            if cell == selectedCell {
                selectedCell.isExpanded.toggle()
                self.isExpanded = selectedCell.isExpanded
            } else {
                self.nonSelectedCells(cell: cell, selectedCellType: selectedCellType)
            }
            self.isExpanded = selectedCell.isExpanded
            completion()
        }
    }
    
    private func checkIfSelectedCellSharedCell1(_ tableView: UITableView, at indexPath: IndexPath, selectedCellType: SelectedCellType, completion: @escaping () -> Void) {
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? SharedCell1 else { return }
        tableView.visibleCells.forEach { [weak self] cell in
            guard let self else { return }
            if cell == selectedCell {
                selectedCell.isExpanded.toggle()
                self.isExpanded = selectedCell.isExpanded
            } else {
                self.nonSelectedCells(cell: cell, selectedCellType: selectedCellType)
            }
            self.isExpanded = selectedCell.isExpanded
            completion()
        }
    }
    
    private func checkIfSelectedCellSharedCell2(_ tableView: UITableView, at indexPath: IndexPath, selectedCellType: SelectedCellType, completion: @escaping () -> Void) {
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? SharedCell2 else { return }
        tableView.visibleCells.forEach { [weak self] cell in
            guard let self else { return }
            if cell == selectedCell {
                selectedCell.isExpanded.toggle()
                self.isExpanded = selectedCell.isExpanded
            } else {
                self.nonSelectedCells(cell: cell, selectedCellType: selectedCellType)
            }
            self.isExpanded = selectedCell.isExpanded
            completion()
        }
    }
    
    private func nonSelectedCells(cell: UITableViewCell, selectedCellType: SelectedCellType) {
        guard categoryType != nil else { return }
        switch selectedCellType {
        case .pharmacyCell:
            guard let cell = cell as? PharmacyCell else { return }
            cell.isExpanded ? cell.isExpanded.toggle() : nil
        case .sharedCell1:
            guard let cell = cell as? SharedCell1 else { return }
            cell.isExpanded ? cell.isExpanded.toggle() : nil
        case .sharedCell2:
            guard let cell = cell as? SharedCell2 else { return }
            cell.isExpanded ? cell.isExpanded.toggle() : nil
        }
    }
    
    //MARK: - Set Loading Animate State
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
                    self?.hospitals.onNext(hospitals)
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
                    self?.healthCenters.onNext(healthCenters)
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
                    self?.dentalCenters.onNext(dentalCenters)
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
                    self?.pharmacies.onNext(pharmacies)
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
                    self?.medicalLaboratories.onNext(medicalLaboratories)
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
                    self?.radiologyCenters.onNext(radiologyCenters)
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
                    self?.animalHospitals.onNext(animalHospitals)
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
                    self?.psychologistCenters.onNext(psychologistCenters)
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
                    self?.gynecologyCenters.onNext(gynecologyCenters)
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
                    self?.opticCenters.onNext(optikCenters)
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
                    self?.privateDentalCenters.onNext(privateDentalCenters)
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
                    self?.spaCenters.onNext(spaCenters)
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
                    self?.dialysisCenters.onNext(dialysisCenters)
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
                    self?.emergencyCenters.onNext(emergencyCenters)
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
                    self?.medicalShopCenters.onNext(medicalShopCenters)
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
                    self?.physiotheraphyCenters.onNext(physiotheraphyCenters)
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
                    self?.pharmacies.onNext(dutyPharmacies)
                case .error(let error):
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: error.localizedDescription)
                case .completed:
                    self?.setLoadingAnimateState(fetchingOrganizations: false, fetchedOrganizations: nil, errorMsg: nil)
                }
            }.disposed(by: disposeBag)
        }
    }
}

