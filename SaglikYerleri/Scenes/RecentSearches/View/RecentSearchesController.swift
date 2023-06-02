//
//  RecentSearchesController.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 26.05.2023.
//

import UIKit
import RxSwift
import MapKit

final class RecentSearchesController: UIViewController {
    deinit {
        print("RecentSearchesController deinit")
    }
    //MARK: - References
    private let recentSearchesView = RecentSearchesView()
    private let viewModel = RecentSearchesViewModel()
    private let header = RecentSearchesHeaderView()
    private let footer = RecentSearchesFooterView()
    
    //MARK: - Dispose Bag
    private let disposeBag = DisposeBag()
    
    //MARK: - Variables
    var cellType: CellType?
    var selectedCellIndexPath: IndexPath?
    var isExpanded: Bool = false
    
    //MARK: - Init Methods
    override func loadView() {
        super.loadView()
        view = recentSearchesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    //MARK: - Configure ViewController
    private func configureViewController() {
        configureTableView()
        configureNavItems()
    }
    
    private func configureNavItems() {
        title = "Son Arananalar"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Geri", style: .plain, target: nil, action: nil)
    }
    
    
    
}

//MARK: - Configure TableView
extension RecentSearchesController {
    private func configureTableView() {
        let tableView = recentSearchesView.recentSearchesTableView
        // bind data
        viewModel.tableViewDataSource().bind(to: tableView.rx.items) { tableView, index, data in
            if let pharmacyCellData = data as? PharmacyCellData {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PharmacyCell.identifier, for: IndexPath(row: index, section: 0)) as? PharmacyCell else { return UITableViewCell() }
                cell.configure(with: pharmacyCellData)
                
                
                cell.didtapLocationButton.subscribe { [weak self] _ in
                    guard let self else { return }
                    let lat = pharmacyCellData.pharmacyLat
                    let lng = pharmacyCellData.pharmacyLng
                    let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                    
                    let mapAlertController = MapAlertController(title: "Yol tarifi al", message: nil, preferredStyle: .alert)
                    mapAlertController.showAlert(on: self, fromRecentSearch: coordinate)
                }.disposed(by: cell.disposeBag)
                
                
                return cell
            } else if let sharedCell1Data = data as? SharedCell1Data {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SharedCell1.identifier, for: IndexPath(row: index, section: 0)) as? SharedCell1 else { return UITableViewCell() }
                cell.configure(with: sharedCell1Data)
                
                
                
                cell.didtapLocationButton.subscribe { [weak self] _ in
                    guard let self else { return }
                    let lat = sharedCell1Data.sharedCell1Lat
                    let lng = sharedCell1Data.sharedCell1Lng
                    let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                    
                    let mapAlertController = MapAlertController(title: "Yol tarifi al", message: nil, preferredStyle: .alert)
                    mapAlertController.showAlert(on: self, fromRecentSearch: coordinate)
                }.disposed(by: cell.disposeBag)
                
                
                return cell
            } else if let sharedCell2Data = data as? SharedCell2Data {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SharedCell2.identifier, for: IndexPath(row: index, section: 0)) as? SharedCell2 else { return UITableViewCell() }
                cell.configure(with: sharedCell2Data)
                
                
                cell.didtapLocationButton.subscribe { [weak self] _ in
                    guard let self else { return }
                    let lat = sharedCell2Data.sharedCell2Lat
                    let lng = sharedCell2Data.sharedCell2Lng
                    let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                    
                    let mapAlertController = MapAlertController(title: "Yol tarifi al", message: nil, preferredStyle: .alert)
                    mapAlertController.showAlert(on: self, fromRecentSearch: coordinate)
                }.disposed(by: cell.disposeBag)
                
                
                return cell
            }
            
            return UITableViewCell()
        }.disposed(by: disposeBag)
        
        // handle cell selections
        tableView.rx.itemSelected.subscribe { [weak self] indexPath in
            guard let self else { return }
            self.whenCellSelected(tableView, indexPath: indexPath, completion: { tableView in
                tableView.deselectRow(at: indexPath, animated: true)
                tableView.beginUpdates()
                tableView.endUpdates()
            })
        }.disposed(by: disposeBag)
        
        // fetch data
        viewModel.fetchDataFromCoreData()
        
        // set delegate for cell height
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
    }
    
    
    
}

extension RecentSearchesController: UITableViewDelegate {
    
    //MARK: - Expand cell When Selected
    func whenCellSelected(_ tableView: UITableView, indexPath: IndexPath, completion: @escaping (UITableView) -> Void) {
        self.selectedCellIndexPath = indexPath
        self.cellForRow(tableView, at: indexPath) {
            completion(tableView)
        }
        
        
    }
    
    private func cellForRow(_ tableView: UITableView, at indexPath: IndexPath, completion: @escaping () -> Void) {
        if let _ = tableView.cellForRow(at: indexPath) as? PharmacyCell {
            self.cellType = .pharmacyCell
            self.checkIfSelectedCellPharmacyCell(tableView, at: indexPath, selectedCellType: .pharmacyCell) {
                completion()
            }
        } else if let _ = tableView.cellForRow(at: indexPath) as? SharedCell1 {
            self.cellType = .sharedCell1
            self.checkIfSelectedCellSharedCell1(tableView, at: indexPath, selectedCellType: .sharedCell1) {
                completion()
            }
        } else if let _ = tableView.cellForRow(at: indexPath) as? SharedCell2 {
            self.cellType = .sharedCell2
            self.checkIfSelectedCellSharedCell2(tableView, at: indexPath, selectedCellType: .sharedCell2) {
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
                self.nonSelectedCells(cell: cell)
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
                self.nonSelectedCells(cell: cell)
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
                self.nonSelectedCells(cell: cell)
            }
            self.isExpanded = selectedCell.isExpanded
            completion()
        }
    }
    
    private func nonSelectedCells(cell: UITableViewCell) {
        if let pharmacyCell = cell as? PharmacyCell {
            pharmacyCell.isExpanded ? pharmacyCell.isExpanded.toggle() : nil
            
        } else if let sharedCell1 = cell as? SharedCell1 {
            sharedCell1.isExpanded ? sharedCell1.isExpanded.toggle() : nil
            
        } else if let sharedCell2 = cell as? SharedCell2 {
            sharedCell2.isExpanded ? sharedCell2.isExpanded.toggle() : nil
            
        }
    }
    
    // Cell Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let selectedCellIndexPath {
            if selectedCellIndexPath == indexPath {
                guard let cellType else { return 96 }
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
        guard let cellType else { return 96 }
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
    
}
