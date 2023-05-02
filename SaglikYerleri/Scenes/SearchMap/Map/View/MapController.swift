//
//  MapController.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 26.04.2023.
//

import UIKit
import RxCocoa
import RxSwift

final class MapController: UIViewController {
    
    //MARK: - References
    private let mapView = MapView()
    var viewModel: MapViewModel?
    
    var categoryType: NetworkConstants?
    var searchController : UISearchController?
    var searchResultController: SearchResultController?
    
    //MARK: - Dispose Bag
    private let disposeBag = DisposeBag()

    
    //MARK: - Life Cycle Methods
    init(categoryType: NetworkConstants) {
        self.categoryType = categoryType
        self.searchResultController = SearchResultController(categoryType: categoryType)
        self.searchController = UISearchController(searchResultsController: searchResultController)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    private func configureViewController() {
        self.navigationItem.searchController = self.searchController
        subscribeTo()
    }
    
    private func subscribeTo() {
        configureSearchBarPlaceHolder(categoryType: categoryType)
        subscribeToSearchBar()
        subscribeToSearchResultControllerVariables()
    }
    
}

//MARK: - SearchController Subscribes
extension MapController {
    
    private func subscribeToSearchResultControllerVariables() {
        searchResultController?.county.subscribe(onNext: { [weak self] countySlug in
            guard let city = self?.searchResultController?.city else { return }
            self?.viewModel?.fetchOrganizations(city: city, county: countySlug)
        }).disposed(by: searchResultController?.disposeBag ?? disposeBag)
    }
    
    private func subscribeToSearchBar() {
//        searchController?.searchBar.rx.text.subscribe(onNext: { [weak self] text in
//            
//        }).disposed(by: searchResultController?.disposeBag ?? disposeBag)
    }
}

//MARK: - Configure Search Bar Placeholder

extension MapController {
    
    private func configureSearchBarPlaceHolder(categoryType: NetworkConstants?) {
        guard let categoryType else { return }
        let searchBarPlaceholder: String = "Bulunduğunuz şehiri arayınız..."
        switch categoryType {
        case .hospitals:
            self.title = "Hastaneler"
            self.searchController?.searchBar.placeholder = searchBarPlaceholder
        case .healthCenters:
            self.title = "Sağlık Ocakları"
            self.searchController?.searchBar.placeholder = searchBarPlaceholder
        case .dentalCenters:
            self.title = "Diş Sağlığı Merk."
            self.searchController?.searchBar.placeholder = searchBarPlaceholder
        case .pharmacy:
            self.title = "Eczaneler"
            self.searchController?.searchBar.placeholder = searchBarPlaceholder
        case .medicalLaboratories:
            self.title = "Medikal Lab."
            self.searchController?.searchBar.placeholder = searchBarPlaceholder
        case .radiologyCenters:
            self.title = "Radyoloji Merk."
            self.searchController?.searchBar.placeholder = searchBarPlaceholder
        case .animalHospitals:
            self.title = "Veterinerler"
            self.searchController?.searchBar.placeholder = searchBarPlaceholder
        case .psychologistCenters:
            self.title = "Psikoloji Merk."
            self.searchController?.searchBar.placeholder = searchBarPlaceholder
        case .gynecologyCenters:
            self.title = "Jinekolog Merk."
            self.searchController?.searchBar.placeholder = searchBarPlaceholder
        case .optikCenters:
            self.title = "Optik Merk."
            self.searchController?.searchBar.placeholder = searchBarPlaceholder
        }
    }
}
