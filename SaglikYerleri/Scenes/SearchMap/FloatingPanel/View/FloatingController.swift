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

enum SelectedCellType {
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
    var selectedCellType: SelectedCellType?
    
    //MARK: - Life Cycle Methods
    init(categoryType: NetworkConstants, mapController: MapController, networkService: OrganizationsService, citySlug: String, countySlug: String, cityName: String, countyName: String) {
        self.mapController = mapController
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
        
        configureTableViewCell()
        viewModel?.configureTableView(tableView: floatingView.placesTableView, floatingController: self)
        configureTableViewSelections()
    }
    
    
}

//MARK: - Configure TableView
extension FloatingController: UITableViewDelegate {
    private func configureTableViewCell() {
        viewModel?.configurePharmacyCell.subscribe(onNext: { [weak self] cell, pharmacy in
            cell.configure(with: pharmacy)
            cell.didtapLocationButton.subscribe { [weak self] _ in
                guard let self, let organizationCoordinates = cell.organizationInfo else { return }
                self.mapController?.viewModel.organizations.onNext(organizationCoordinates)
            }.disposed(by: cell.disposeBag)
        }).disposed(by: disposeBag)
        
        viewModel?.configureSharedCell1.subscribe(onNext: { [weak self] cell, data in
            cell.configure(with: data)
            cell.didtapLocationButton.subscribe { [weak self] _ in
                guard let self, let organizationCoordinates = cell.organizationInfo else { return }
                self.mapController?.viewModel.organizations.onNext(organizationCoordinates)
            }.disposed(by: cell.disposeBag)
        }).disposed(by: disposeBag)
        
        viewModel?.configureSharedCell2.subscribe(onNext: { [weak self] cell, data in
            cell.configure(with: data)
            cell.didtapLocationButton.subscribe { [weak self] _ in
                guard let self, let organizationCoordinates = cell.organizationInfo else { return }
                self.mapController?.viewModel.organizations.onNext(organizationCoordinates)
            }.disposed(by: cell.disposeBag)
        }).disposed(by: disposeBag)
    }
    
    private func configureTableViewSelections() {
        viewModel?.tableViewCellSelected.subscribe(onNext: { [weak self] tableView, indexPath in
            guard let self else { return }
            self.viewModel?.whenCellSelected(tableView, indexPath: indexPath, completion: { tableView in
                tableView.deselectRow(at: indexPath, animated: true)
                tableView.beginUpdates()
                tableView.endUpdates()
            })
        }).disposed(by: disposeBag)
    }
    
    // Cell Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let viewModel else { return 96 }
        let cellHeight = viewModel.heightForRowAt(tableView, heightForRowAt: indexPath)
        
        return cellHeight
    }
    
    
    //MARK: - TableViewHeader
    // Header Height
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = viewModel?.viewForHeaderInSection(tableHeaderView: tableHeaderView)
        
        return headerView
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
