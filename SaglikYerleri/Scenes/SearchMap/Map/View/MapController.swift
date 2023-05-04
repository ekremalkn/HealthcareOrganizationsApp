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
        subscribeToSearchBarText()
        subscribeToSearchResultControllerVariables()
    }
    
}

//MARK: - MapController Subscribes
extension MapController {
    
    private func subscribeToSearchResultControllerVariables() {
        searchResultController?.selectedCountySlug.subscribe(onNext: { [weak self] countySlug in
            guard let city = self?.searchResultController?.city else { return }
            self?.viewModel?.fetchOrganizations(city: city, county: countySlug)
        }).disposed(by: searchResultController?.disposeBag ?? disposeBag)
        
        searchResultController?.searchControllerDissmissed.subscribe(onNext: { [weak self] _ in
            guard let self else { return }
            self.mapView.congfigureAlphaView(hideAlphaView: true)
        }).disposed(by: searchResultController?.disposeBag ?? disposeBag)
        
        searchResultController?.selectedCountyName.subscribe(onNext: { [weak self] countyName in
            guard let self else { return }
            self.searchController?.searchBar.text = countyName
        }).disposed(by: searchResultController?.disposeBag ?? disposeBag)
        
        // Search Controller ViewModel Loading States
        searchResultController?.viewModel?.fetchingCities.subscribe(onNext: { [weak self] value in
            value ? self?.mapView.loadingView.animationView?.play() : self?.mapView.loadingView.animationView?.stop()
        }).disposed(by: searchResultController?.disposeBag ?? disposeBag)
        
        searchResultController?.viewModel?.fetchedCities.subscribe(onNext: { [weak self] _ in
            self?.mapView.loadingView.animationView?.stop()
        }).disposed(by: searchResultController?.disposeBag ?? disposeBag)
        
        searchResultController?.viewModel?.errorMsg.subscribe(onNext: { [weak self] errorMsg in
            self?.mapView.loadingView.animationView?.play()
        }).disposed(by: searchResultController?.disposeBag ?? disposeBag)
    }
    
    private func subscribeToSearchBarText() {
        searchController?.searchBar.rx.text.subscribe(onNext: { [weak self] text in
            guard let text else { return }
            self?.searchResultController?.viewModel?.filterCityCounty(character: text)
        }).disposed(by: searchResultController?.disposeBag ?? disposeBag)
        
        searchController?.searchBar.rx.textDidBeginEditing.subscribe(onNext: { [weak self] _ in
            guard let self else { return }
            self.mapView.congfigureAlphaView(hideAlphaView: false)
        }).disposed(by: disposeBag)
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
            self.title = "Diş Klinikleri"
            self.searchController?.searchBar.placeholder = searchBarPlaceholder
        case .pharmacy:
            self.title = "Eczaneler"
            self.searchController?.searchBar.placeholder = searchBarPlaceholder
        case .medicalLaboratories:
            self.title = "Tıbbi Lab."
            self.searchController?.searchBar.placeholder = searchBarPlaceholder
        case .radiologyCenters:
            self.title = "Radyoloji Merk."
            self.searchController?.searchBar.placeholder = searchBarPlaceholder
        case .animalHospitals:
            self.title = "Hayvan Hastaneleri"
            self.searchController?.searchBar.placeholder = searchBarPlaceholder
        case .psychologistCenters:
            self.title = "Psikologlar"
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
