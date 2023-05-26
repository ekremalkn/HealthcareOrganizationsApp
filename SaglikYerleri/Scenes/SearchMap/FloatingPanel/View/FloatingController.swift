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

enum CellType {
    case pharmacyCell
    case sharedCell1
    case sharedCell2
}

final class FloatingController: UIViewController {
    
    //MARK: - References
    let viewModel: FloatingViewModel?
    private let floatingView = FloatingView()
    private let tableHeaderView = PlacesTableHeaderView()
    weak var mapController: MapController?
    
    //MARK: - Dispose Bag
    private let disposeBag = DisposeBag()
    
    //MARK: - Variables
    let categoryType: NetworkConstants?
    var cellType: CellType
    var selectedCellIndexPath: IndexPath?
    var isExpanded: Bool = false
    
    
    //MARK: - Life Cycle Methods
    init(categoryType: NetworkConstants, cellType: CellType, mapController: MapController, networkService: OrganizationsService, citySlug: String, countySlug: String, cityName: String, countyName: String) {
        self.mapController = mapController
        self.cellType = cellType
        self.viewModel = FloatingViewModel(categoryType: categoryType, networkService: networkService, citySlug: citySlug, countySlug: countySlug, cityName: cityName, countyName: countyName)
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

extension FloatingController {
    private func configureTableView() {
        guard let viewModel else { return }
        let tableView = floatingView.placesTableView
        // Bind data
        switch cellType {
        case .pharmacyCell:
            viewModel.pharmacyCellData.bind(to: tableView.rx.items(cellIdentifier: PharmacyCell.identifier, cellType: PharmacyCell.self)) { [weak self] index, pharmacyCellData, cell in
                self?.configurePharmacyCell(cell, pharmacyCellData)
            }.disposed(by: disposeBag)
        case .sharedCell1:
            viewModel.sharedCell1Data.bind(to: tableView.rx.items(cellIdentifier: SharedCell1.identifier, cellType: SharedCell1.self)) { [weak self] index, sharedCell1Data, cell in
                self?.configureSharedCell1(cell, sharedCell1Data)
            }.disposed(by: disposeBag)
        case .sharedCell2:
            viewModel.sharedCell2Data.bind(to: tableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { [weak self] index, sharedCell2Data, cell in
                self?.configureSharedCell2(cell, sharedCell2Data)
            }.disposed(by: disposeBag)
        }
        
        // Fetch Organizations
        viewModel.fetchOrganizations()
        
        tableView.rx.itemSelected.subscribe { [weak self] indexPath in
            guard let self else { return }
            self.whenCellSelected(tableView, indexPath: indexPath, completion: { tableView in
                tableView.deselectRow(at: indexPath, animated: true)
                tableView.beginUpdates()
                tableView.endUpdates()
            })
            
            
        }.disposed(by: disposeBag)
        // Set delegate for TableView Cell Height / Header Height
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
    }
}

//MARK: - Configure TableView
extension FloatingController: UITableViewDelegate {
    private func configurePharmacyCell(_ cell: PharmacyCell, _ data: PharmacyCellDataProtocol) {
        cell.configure(with: data)
        cell.didtapLocationButton.subscribe { [weak self] _ in
            guard let self, let organizationCoordinates = cell.organizationInfo else { return }
            self.mapController?.viewModel.organizations.onNext(organizationCoordinates)
        }.disposed(by: cell.disposeBag)
    }
    
    private func configureSharedCell1(_ cell: SharedCell1, _ data: SharedCell1DataProtocol) {
        cell.configure(with: data)
        cell.didtapLocationButton.subscribe { [weak self] _ in
            guard let self, let organizationCoordinates = cell.organizationInfo else { return }
            self.mapController?.viewModel.organizations.onNext(organizationCoordinates)
        }.disposed(by: cell.disposeBag)
    }
    
    private func configureSharedCell2(_ cell: SharedCell2, _ data: SharedCell2DataProtocol) {
        cell.configure(with: data)
        cell.didtapLocationButton.subscribe { [weak self] _ in
            guard let self, let organizationCoordinates = cell.organizationInfo else { return }
            self.mapController?.viewModel.organizations.onNext(organizationCoordinates)
        }.disposed(by: cell.disposeBag)
    }
    
}


extension FloatingController {
    
    //MARK: - Expand cell When Selected
    func whenCellSelected(_ tableView: UITableView, indexPath: IndexPath, completion: @escaping (UITableView) -> Void) {
        self.selectedCellIndexPath = indexPath
        self.cellForRow(tableView, at: indexPath) {
            completion(tableView)
        }
        
        
    }
    
    private func cellForRow(_ tableView: UITableView, at indexPath: IndexPath, completion: @escaping () -> Void) {
        switch cellType {
        case .pharmacyCell:
            self.checkIfSelectedCellPharmacyCell(tableView, at: indexPath, selectedCellType: cellType) {
                completion()
            }
        case .sharedCell1:
            self.checkIfSelectedCellSharedCell1(tableView, at: indexPath, selectedCellType: cellType) {
                completion()
            }
        case .sharedCell2:
            self.checkIfSelectedCellSharedCell2(tableView, at: indexPath, selectedCellType: cellType) {
                completion()
            }
            
        }
    }
    
    private func checkIfSelectedCellPharmacyCell(_ tableView: UITableView, at indexPath: IndexPath, selectedCellType: CellType, completion: @escaping () -> Void) {
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
    
    private func checkIfSelectedCellSharedCell1(_ tableView: UITableView, at indexPath: IndexPath, selectedCellType: CellType, completion: @escaping () -> Void) {
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
    
    private func checkIfSelectedCellSharedCell2(_ tableView: UITableView, at indexPath: IndexPath, selectedCellType: CellType, completion: @escaping () -> Void) {
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
    
    private func nonSelectedCells(cell: UITableViewCell, selectedCellType: CellType) {
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
        if let selectedCellIndexPath {
            if selectedCellIndexPath == indexPath {
                switch cellType {
                case .pharmacyCell:
                    return isExpanded ? self.calculateCellHeight(tableView: tableView, at: indexPath) : 96
                case .sharedCell1:
                    return isExpanded ? self.calculateCellHeight(tableView: tableView, at: indexPath) : 96
                case .sharedCell2:
                    return isExpanded ? self.calculateCellHeight(tableView: tableView, at: indexPath) : 96
                }
                
            }
        }
        return 96
    }
    
    private func calculateCellHeight(tableView: UITableView ,at indexPath: IndexPath) -> CGFloat {
        switch cellType {
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
            guard let self else { return }
            self.floatingView.loadingView.isHidden = value ? false : true
            print("fetching")
        }).disposed(by: disposeBag)
        
        viewModel?.fetchedOrganizations.subscribe(onNext: { [weak self] _ in
            guard let self else { return }
            self.floatingView.loadingView.isHidden = true
            print("fetched")
        }).disposed(by: disposeBag)
        
        viewModel?.errorMsg.subscribe(onNext: { errorMsg in
            print(errorMsg)
        }).disposed(by: disposeBag)
    }
}
