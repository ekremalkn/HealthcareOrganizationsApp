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
    
    //MARK: - References
    let viewModel: FloatingViewModel?
    private let floatingView = FloatingView()
    private let tableHeaderView = PlacesTableHeaderView()
    
    //MARK: - Dispose Bag
    private let disposeBag = DisposeBag()
    
    //MARK: - Variables
    let categoryType: NetworkConstants?
    
    //MARK: - Life Cycle Methods
    init(categoryType: NetworkConstants, citySlug: String, countySlug: String, cityName: String, countyName: String) {
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
            viewModel.pharmacies.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: PharmacyCell.identifier, cellType: PharmacyCell.self)) { index, pharmacy, cell in
                cell.configure(with: pharmacy)
            }.disposed(by: disposeBag)
        case .medicalLaboratories:
            viewModel.medicalLaboratories.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: SharedCell1.identifier, cellType: SharedCell1.self)) { index, medicalLaboratory, cell in
                cell.configure(with: medicalLaboratory)
            }.disposed(by: disposeBag)
        case .radiologyCenters:
            viewModel.radiologyCenters.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: SharedCell1.identifier, cellType: SharedCell1.self)) { index, radiologyCenter, cell in
                cell.configure(with: radiologyCenter)
            }.disposed(by: disposeBag)
        case .healthCenters:
            viewModel.healthCenters.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: SharedCell1.identifier, cellType: SharedCell1.self)) { index, healthCenter, cell in
                cell.configure(with: healthCenter)
            }.disposed(by: disposeBag)
        case .hospitals:
            viewModel.hospitals.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: SharedCell1.identifier, cellType: SharedCell1.self)) { index, hospital, cell in
                cell.configure(with: hospital)
            }.disposed(by: disposeBag)
        case .dentalCenters:
            viewModel.dentalCenters.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { index, dentalCenter, cell in
                cell.configure(with: dentalCenter)
            }.disposed(by: disposeBag)
        case .privateDentalCenters:
            viewModel.privateDentalCenters.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { index, privateDentalCenter, cell in
                cell.configure(with: privateDentalCenter)
            }.disposed(by: disposeBag)
        case .spaCenters:
            viewModel.spaCenters.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { index, spaCenter, cell in
                cell.configure(with: spaCenter)
            }.disposed(by: disposeBag)
        case .psychologistCenters:
            viewModel.psychologistCenters.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { index, psychologistCenter, cell in
                cell.configure(with: psychologistCenter)
            }.disposed(by: disposeBag)
        case .gynecologyCenters:
            viewModel.dentalCenters.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { index, gynecologyCenter, cell in
                cell.configure(with: gynecologyCenter)
            }.disposed(by: disposeBag)
        case .opticCenters:
            viewModel.opticCenters.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { index, opticCenter, cell in
                cell.configure(with: opticCenter)
            }.disposed(by: disposeBag)
        case .animalHospitals:
            viewModel.animalHospitals.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { index, animalHospital, cell in
                cell.configure(with: animalHospital)
            }.disposed(by: disposeBag)
        case .dialysisCenters:
            viewModel.dialysisCenters.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { index, dialysisCenter, cell in
                cell.configure(with: dialysisCenter)
            }.disposed(by: disposeBag)
        case .emergencyCenters:
            viewModel.emergencyCenters.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { index, emergencyCenter, cell in
                cell.configure(with: emergencyCenter)
            }.disposed(by: disposeBag)
        case .medicalShopCenters:
            viewModel.medicalShopCenters.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { index, medicalShopCenter, cell in
                cell.configure(with: medicalShopCenter)
            }.disposed(by: disposeBag)
        case .physiotheraphyCenters:
            viewModel.physiotheraphyCenters.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: SharedCell2.identifier, cellType: SharedCell2.self)) { index, physiotheraphyCenter, cell in
                cell.configure(with: physiotheraphyCenter)
            }.disposed(by: disposeBag)
        case .dutyPharmacy:
            viewModel.pharmacies.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: PharmacyCell.identifier, cellType: PharmacyCell.self)) { index, pharmacy, cell in
                cell.configure(with: pharmacy)
            }.disposed(by: disposeBag)
        }
        
        // Fetch Organizations
        viewModel.fetchOrganizations()
        
        // Set delegate for TableView Cell Height / Header Height
        floatingView.placesTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        // Set header view
        
        
    }
 
    // Cell Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight: CGFloat = 30
        guard let categoryType else { return cellHeight}
        
        switch categoryType {
        case .pharmacy:
            let pharmacyCellHeight: CGFloat = tableView.frame.height / 4
            cellHeight = pharmacyCellHeight
        case .medicalLaboratories:
            let pharmacyCellHeight: CGFloat = tableView.frame.height / 5
            cellHeight = pharmacyCellHeight
        case .radiologyCenters:
            let pharmacyCellHeight: CGFloat = tableView.frame.height / 5
            cellHeight = pharmacyCellHeight
        case .healthCenters:
            let pharmacyCellHeight: CGFloat = tableView.frame.height / 5
            cellHeight = pharmacyCellHeight
        case .hospitals:
            let pharmacyCellHeight: CGFloat = tableView.frame.height / 5
            cellHeight = pharmacyCellHeight
        case .dentalCenters:
            let pharmacyCellHeight: CGFloat = tableView.frame.height / 5
            cellHeight = pharmacyCellHeight
        case .privateDentalCenters:
            let pharmacyCellHeight: CGFloat = tableView.frame.height / 5
            cellHeight = pharmacyCellHeight
        case .spaCenters:
            let pharmacyCellHeight: CGFloat = tableView.frame.height / 5
            cellHeight = pharmacyCellHeight
        case .psychologistCenters:
            let pharmacyCellHeight: CGFloat = tableView.frame.height / 5
            cellHeight = pharmacyCellHeight
        case .gynecologyCenters:
            let pharmacyCellHeight: CGFloat = tableView.frame.height / 5
            cellHeight = pharmacyCellHeight
        case .opticCenters:
            let pharmacyCellHeight: CGFloat = tableView.frame.height / 5
            cellHeight = pharmacyCellHeight
        case .animalHospitals:
            let pharmacyCellHeight: CGFloat = tableView.frame.height / 5
            cellHeight = pharmacyCellHeight
        case .dialysisCenters:
            let pharmacyCellHeight: CGFloat = tableView.frame.height / 5
            cellHeight = pharmacyCellHeight
        case .emergencyCenters:
            let pharmacyCellHeight: CGFloat = tableView.frame.height / 5
            cellHeight = pharmacyCellHeight
        case .medicalShopCenters:
            let pharmacyCellHeight: CGFloat = tableView.frame.height / 5
            cellHeight = pharmacyCellHeight
        case .physiotheraphyCenters:
            let pharmacyCellHeight: CGFloat = tableView.frame.height / 5
            cellHeight = pharmacyCellHeight
        case .dutyPharmacy:
            let pharmacyCellHeight: CGFloat = tableView.frame.height / 4
            cellHeight = pharmacyCellHeight
        }
        
        return cellHeight
    }
    
    // Header Height
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let numberOfItems = viewModel?.numberOfItems ,let cityName = viewModel?.citySlug, let countyName = viewModel?.countySlug else { return UIView() }
        tableHeaderView.configure(with: numberOfItems, cityName: cityName, countySlug: countyName)
        
        return tableHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}
