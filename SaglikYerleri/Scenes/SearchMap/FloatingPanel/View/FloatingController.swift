//
//  FloatingController.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 5.05.2023.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class FloatingController: UIViewController {
    
    enum SelectedCellType {
        case pharmacyCell
        case sharedCell1
        case sharedCell2
    }
    
    //MARK: - References
    let viewModel: FloatingViewModel?
    private let floatingView = FloatingView()
    private let tableHeaderView = PlacesTableHeaderView()
    weak var mapController: MapController?
    
    //MARK: - Dispose Bag
    private let disposeBag = DisposeBag()
    
    //MARK: - Variables
    let categoryType: NetworkConstants?
    var selectedCellType: SelectedCellType?
    
    var selectedCellIndexPath: IndexPath?
    var isExpanded: Bool = false
    
    //MARK: - Life Cycle Methods
    init(categoryType: NetworkConstants, mapController: MapController, citySlug: String, countySlug: String, cityName: String, countyName: String) {
        self.mapController = mapController
        self.viewModel = FloatingViewModel(categoryType: categoryType, citySlug: citySlug, countySlug: countySlug, cityName: cityName, countyName: countyName)
        self.categoryType = categoryType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle Methods
    override func loadView() {
        super.loadView()
        view = floatingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    //MARK: - Configure ViewController
    private func configureViewController() {
        subscribeToViewModelFetcingStates()
        configureTableView()
    }
    
    
}

//MARK: - Configure TableView
extension FloatingController: UITableViewDelegate {
    private func configureTableView() {
        guard let viewModel, let categoryType else { return }
        // Bind data
        switch categoryType {
        case .pharmacy:
            viewModel.pharmacies.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: PharmacyCell.identifier, cellType: PharmacyCell.self)) { [weak self] index, pharmacy, cell in
                self?.selectedCellType = .pharmacyCell
                cell.configure(with: pharmacy)
            }.disposed(by: disposeBag)
        case .medicalLaboratories:
            viewModel.medicalLaboratories.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: SharedCell1.identifier, cellType: SharedCell1.self)) { [weak self] index, medicalLaboratory, cell in
                self?.selectedCellType = .sharedCell1
                cell.configure(with: medicalLaboratory)
            }.disposed(by: disposeBag)
        case .radiologyCenters:
            viewModel.radiologyCenters.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: SharedCell1.identifier, cellType: SharedCell1.self)) { [weak self] index, radiologyCenter, cell in
                self?.selectedCellType = .sharedCell1
                cell.configure(with: radiologyCenter)
            }.disposed(by: disposeBag)
        case .healthCenters:
            viewModel.healthCenters.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: SharedCell1.identifier, cellType: SharedCell1.self)) { [weak self] index, healthCenter, cell in
                self?.selectedCellType = .sharedCell1
                cell.configure(with: healthCenter)
            }.disposed(by: disposeBag)
        case .hospitals:
            viewModel.hospitals.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: SharedCell1.identifier, cellType: SharedCell1.self)) { [weak self] index, hospital, cell in
                self?.selectedCellType = .sharedCell1
                cell.configure(with: hospital)
            }.disposed(by: disposeBag)
        case .dentalCenters:
            viewModel.dentalCenters.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { [weak self] index, dentalCenter, cell in
                self?.selectedCellType = .sharedCell2
                cell.configure(with: dentalCenter)
            }.disposed(by: disposeBag)
        case .privateDentalCenters:
            viewModel.privateDentalCenters.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { [weak self] index, privateDentalCenter, cell in
                self?.selectedCellType = .sharedCell2
                cell.configure(with: privateDentalCenter)
            }.disposed(by: disposeBag)
        case .spaCenters:
            viewModel.spaCenters.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { [weak self] index, spaCenter, cell in
                self?.selectedCellType = .sharedCell2
                cell.configure(with: spaCenter)
            }.disposed(by: disposeBag)
        case .psychologistCenters:
            viewModel.psychologistCenters.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { [weak self] index, psychologistCenter, cell in
                self?.selectedCellType = .sharedCell2
                cell.configure(with: psychologistCenter)
            }.disposed(by: disposeBag)
        case .gynecologyCenters:
            viewModel.dentalCenters.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { [weak self] index, gynecologyCenter, cell in
                self?.selectedCellType = .sharedCell2
                cell.configure(with: gynecologyCenter)
            }.disposed(by: disposeBag)
        case .opticCenters:
            viewModel.opticCenters.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { [weak self] index, opticCenter, cell in
                self?.selectedCellType = .sharedCell2
                cell.configure(with: opticCenter)
            }.disposed(by: disposeBag)
        case .animalHospitals:
            viewModel.animalHospitals.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { [weak self] index, animalHospital, cell in
                self?.selectedCellType = .sharedCell2
                cell.configure(with: animalHospital)
            }.disposed(by: disposeBag)
        case .dialysisCenters:
            viewModel.dialysisCenters.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { [weak self] index, dialysisCenter, cell in
                self?.selectedCellType = .sharedCell2
                cell.configure(with: dialysisCenter)
            }.disposed(by: disposeBag)
        case .emergencyCenters:
            viewModel.emergencyCenters.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { [weak self] index, emergencyCenter, cell in
                self?.selectedCellType = .sharedCell2
                cell.configure(with: emergencyCenter)
            }.disposed(by: disposeBag)
        case .medicalShopCenters:
            viewModel.medicalShopCenters.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { [weak self] index, medicalShopCenter, cell in
                self?.selectedCellType = .sharedCell2
                cell.configure(with: medicalShopCenter)
            }.disposed(by: disposeBag)
        case .physiotheraphyCenters:
            viewModel.physiotheraphyCenters.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { [weak self] index, physiotheraphyCenter, cell in
                self?.selectedCellType = .sharedCell2
                cell.configure(with: physiotheraphyCenter)
            }.disposed(by: disposeBag)
        case .dutyPharmacy:
            viewModel.pharmacies.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: PharmacyCell.identifier, cellType: PharmacyCell.self)) { [weak self] index, pharmacy, cell in
                self?.selectedCellType = .pharmacyCell
                cell.configure(with: pharmacy)
            }.disposed(by: disposeBag)
        }
        
        // Fetch Organizations
        viewModel.fetchOrganizations()
        
        floatingView.placesTableView.rx.itemSelected.subscribe { [weak self] indexPath in
            self?.whenCellSelected(indexPath: indexPath, completion: { tableView in
                tableView.deselectRow(at: indexPath, animated: true)
                tableView.beginUpdates()
                tableView.endUpdates()
            })
            
            
        }.disposed(by: disposeBag)
        // Set delegate for TableView Cell Height / Header Height
        floatingView.placesTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
    }
    
    //MARK: - Expand cell When Selected
    private func whenCellSelected(indexPath: IndexPath, completion: @escaping (UITableView) -> Void) {
        let tableView = self.floatingView.placesTableView
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
            if cell == selectedCell {
                selectedCell.isExpanded.toggle()
                self?.isExpanded = selectedCell.isExpanded
            } else {
                self?.nonSelectedCells(cell: cell, selectedCellType: selectedCellType)
            }
            self?.isExpanded = selectedCell.isExpanded
            completion()
        }
    }
    
    private func checkIfSelectedCellSharedCell1(_ tableView: UITableView, at indexPath: IndexPath, selectedCellType: SelectedCellType, completion: @escaping () -> Void) {
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? SharedCell1 else { return }
        tableView.visibleCells.forEach { [weak self] cell in
            if cell == selectedCell {
                selectedCell.isExpanded.toggle()
                self?.isExpanded = selectedCell.isExpanded
            } else {
                self?.nonSelectedCells(cell: cell, selectedCellType: selectedCellType)
            }
            self?.isExpanded = selectedCell.isExpanded
            completion()
        }
    }
    
    private func checkIfSelectedCellSharedCell2(_ tableView: UITableView, at indexPath: IndexPath, selectedCellType: SelectedCellType, completion: @escaping () -> Void) {
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? SharedCell2 else { return }
        
        tableView.visibleCells.forEach { [weak self] cell in
            if cell == selectedCell {
                selectedCell.isExpanded.toggle()
                self?.isExpanded = selectedCell.isExpanded
            } else {
                self?.nonSelectedCells(cell: cell, selectedCellType: selectedCellType)
            }
            self?.isExpanded = selectedCell.isExpanded
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
    
    // Cell Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard categoryType != nil else { return CGFloat() }
        guard let selectedCellType else { return 96 }
        if let selectedCellIndexPath {
            if selectedCellIndexPath == indexPath {
                switch selectedCellType {
                case .pharmacyCell:
                    print(calculateCellHeight(tableView: tableView, at: indexPath))
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

    
    
    
    //MARK: - TableViewHeader
    // Header Height
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let numberOfItems = viewModel?.numberOfItems ,let cityName = viewModel?.cityName, let countyName = viewModel?.countyName else { return UIView() }
        tableHeaderView.configure(with: numberOfItems, cityName: cityName, countyName: countyName)
        
        return tableHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}

//MARK: - ViewModel Fetching States
extension FloatingController {
    func subscribeToViewModelFetcingStates() {
        viewModel?.fetchingOrganizations.subscribe(onNext: { [weak self] value in
            self?.floatingView.loadingView.isHidden = value ? false : true
            print("fetching")
        }).disposed(by: disposeBag)
        
        viewModel?.fetchedOrganizations.subscribe(onNext: { [weak self] _ in
            self?.floatingView.loadingView.isHidden = true
            print("fetched")
        }).disposed(by: disposeBag)
        
        viewModel?.errorMsg.subscribe(onNext: { errorMsg in
            print(errorMsg)
        }).disposed(by: disposeBag)
    }
}
