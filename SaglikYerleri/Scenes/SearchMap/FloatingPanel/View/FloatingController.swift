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
    
    //MARK: - Dispose Bag
    private let disposeBag = DisposeBag()
    
    //MARK: - Variables
    let categoryType: NetworkConstants?
    
    //MARK: - Life Cycle Methods
    init(categoryType: NetworkConstants, citySlug: String, countySlug: String) {
        self.viewModel = FloatingViewModel(categoryType: categoryType, citySlug: citySlug, countySlug: countySlug)
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
        case .healthCenters:
            viewModel.healthCenters.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { index, healthCenter, cell in
            }.disposed(by: disposeBag)
        case .hospitals:
            break
        case .dentalCenters:
            break
        case .privateDentalCenters:
            break
        case .medicalLaboratories:
            break
        case .radiologyCenters:
            break
        case .spaCenters:
            break
        case .psychologistCenters:
            break
        case .gynecologyCenters:
            break
        case .opticCenters:
            break
        case .animalHospitals:
            break
        case .dialysisCenters:
            break
        case .emergencyCenters:
            break
        case .medicalShopCenters:
            break
        case .physiotheraphyCenters:
            break
        case .dutyPharmacy:
            viewModel.pharmacies.bind(to: floatingView.placesTableView.rx.items(cellIdentifier: PharmacyCell.identifier, cellType: PharmacyCell.self)) { index, pharmacy, cell in
                cell.configure(with: pharmacy)
            }.disposed(by: disposeBag)
        }
        
        // Fetch Organizations
        viewModel.fetchOrganizations()
        
        // Set delegate for TableView Cell Height
        
        floatingView.placesTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight: CGFloat = 30
        guard let categoryType else { return cellHeight}
        
        switch categoryType {
        case .pharmacy:
            let pharmacyCellHeight: CGFloat = tableView.frame.height / 4
            cellHeight = pharmacyCellHeight
        case .healthCenters:
            break
        case .hospitals:
            break
        case .dentalCenters:
            break
        case .privateDentalCenters:
            break
        case .medicalLaboratories:
            break
        case .radiologyCenters:
            break
        case .spaCenters:
            break
        case .psychologistCenters:
            break
        case .gynecologyCenters:
            break
        case .opticCenters:
            break
        case .animalHospitals:
            break
        case .dialysisCenters:
            break
        case .emergencyCenters:
            break
        case .medicalShopCenters:
            break
        case .physiotheraphyCenters:
            break
        case .dutyPharmacy:
            let pharmacyCellHeight: CGFloat = tableView.frame.height / 4
            cellHeight = pharmacyCellHeight
        }
        
        return cellHeight
    }
    
}
