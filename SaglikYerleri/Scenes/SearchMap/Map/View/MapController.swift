//
//  MapController.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 26.04.2023.
//

import UIKit
import RxCocoa
import RxSwift
import MapKit

final class MapController: UIViewController {
    deinit {
        print("deinit map controller")
    }
    //MARK: - Animate Nav Bar to
    enum AnimateNavBarTo {
        case top
        case bottom
    }
    
    //MARK: - References
    var mapCoordinator: MapCoordinator?
    let mapView = MapView()
    let viewModel = MapViewModel()
    
    var categoryType: NetworkConstants?
    var searchController : UISearchController?
    var searchResultController: SearchResultController?
    var customTopViewBC: UIColor?
    
    //MARK: - Dispose Bag
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Life Cycle Methods
    init(categoryType: NetworkConstants, networkService: CityCountyService, customTopViewBC: UIColor) {
        self.categoryType = categoryType
        self.customTopViewBC = customTopViewBC
        self.searchResultController = SearchResultController(categoryType: categoryType, networkService: networkService, backgroundColor: customTopViewBC)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func configureViewController() {
        self.navigationItem.searchController = self.searchController
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = self.mapView.backButton
        configureSearchBarCancelButton()
        self.mapView.mapView.delegate = self
        self.mapView.configureCustomTopView(customTopViewBColor: customTopViewBC!)
        subscribeTo()
    }
    
    private func subscribeTo() {
        subscribeToMapViewModel()
        configureSearchBarPlaceHolder(categoryType: categoryType)
        subscribeToSearchBarText()
        subscribeToSearchResultControllerVariables()
    }
    
}

//MARK: - MapController Subscribes
extension MapController {
    
    private func subscribeToSearchResultControllerVariables() {
        searchResultController?.searchControllerViewDidAppear.subscribe(onNext: { [weak self] _ in
            self?.mapCoordinator?.moveFloatingPanelToTip()
        }).disposed(by: searchResultController?.disposeBag ?? disposeBag)
        
        searchResultController?.searchControllerDissmissed.subscribe(onNext: { [weak self] selectedCitySlug, selectedCountySlug, selectedCityName, selectedCountyName in
            self?.mapView.configureAlphaView(hideAlphaView: true, completion: { [weak self] in
                guard let categoryType = self?.categoryType, let self else { return }
                self.mapCoordinator?.openFloatingController(categoryType: categoryType, mapController: self, citySlug: selectedCitySlug, countySlug: selectedCountySlug, cityName: selectedCityName, countyName: selectedCountyName, parentVC: self)
            })
            
        }).disposed(by: searchResultController?.disposeBag ?? disposeBag)
        
        searchResultController?.viewModel?.selectedCountyName.subscribe(onNext: { [weak self] countyName in
            guard let self else { return }
            self.searchController?.searchBar.text = countyName
        }).disposed(by: searchResultController?.disposeBag ?? disposeBag)
        
        searchResultController?.viewModel?.clearSearchBarText.subscribe(onNext: { [weak self] _ in
            guard let self else { return }
            self.searchController?.searchBar.text?.removeAll()
        }).disposed(by: disposeBag)
        
        searchController?.searchBar.rx.cancelButtonClicked.subscribe(onNext: { _ in
            
        }).disposed(by: disposeBag)
        
        
        // Search Controller ViewModel Loading States
        searchResultController?.viewModel?.fetchingCities.subscribe(onNext: { [weak self] value in
            self?.mapView.loadingView.isHidden = value ? false : true
        }).disposed(by: searchResultController?.disposeBag ?? disposeBag)
        
        searchResultController?.viewModel?.fetchedCities.subscribe(onNext: { [weak self] _ in
            self?.mapView.loadingView.isHidden = true
        }).disposed(by: searchResultController?.disposeBag ?? disposeBag)
        
        searchResultController?.viewModel?.errorMsg.subscribe(onNext: { [weak self] errorMsg in
            self?.mapView.loadingView.isHidden = false
        }).disposed(by: searchResultController?.disposeBag ?? disposeBag)
    }
    
    // SearchBar callbacks
    private func subscribeToSearchBarText() {
        searchController?.searchBar.rx.text.subscribe(onNext: { [weak self] text in
            guard let text else { return }
            self?.searchResultController?.viewModel?.filterCityCounty(character: text)
        }).disposed(by: searchResultController?.disposeBag ?? disposeBag)
        
        searchController?.searchBar.rx.textDidBeginEditing.subscribe(onNext: { [weak self] _ in
            guard let self else { return }
            self.mapView.configureAlphaView(hideAlphaView: false)
        }).disposed(by: disposeBag)
        
        searchController?.searchBar.rx.cancelButtonClicked.subscribe(onNext: { [weak self] _ in
            guard let self else { return }
            self.mapView.configureAlphaView(hideAlphaView: true)
        }).disposed(by: disposeBag)
    }
}

//MARK: - MapView delegate methods
extension MapController:  MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        self.animateNavBarAndTopView(to: .top)
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        self.animateNavBarAndTopView(to: .bottom)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let categoryType else { return nil }
        let customAnnotationView = CustomAnnotationView(annotation: annotation, categoryType: categoryType, name: "123")
        
        customAnnotationView.leftCalloutAccessoryButtonTapped.subscribe { [unowned self] _ in
            let mapAlertController = MapAlertController(title: "Yol tarifi al", message: nil, preferredStyle: .alert)
            mapAlertController.showAlert(on: self, useWhenOkTapped: annotation)
        }.disposed(by: customAnnotationView.disposeBag)
        
        return customAnnotationView
    }
    
    
    private func animateNavBarAndTopView(to aim: AnimateNavBarTo) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self else { return }
            switch aim {
            case .top:
                self.mapView.customTopView.transform = CGAffineTransform(translationX: 0, y: -UIScreen.main.bounds.width / 2)
                self.navigationController?.navigationBar.transform = CGAffineTransform(translationX: 0, y: -UIScreen.main.bounds.width / 2)
                if self.mapCoordinator?.floatingPanel?.state != .tip {
                    self.mapCoordinator?.moveFloatingPanelToTip()
                }
            case .bottom:
                self.mapView.customTopView.transform = .identity
                self.navigationController?.navigationBar.transform = .identity
            }
        }
        
        
    }
}

//MARK: - MapViewModelSubscribes
extension MapController {
    private func subscribeToMapViewModel() {
        // Set Region
        viewModel.organizations.subscribe(onNext: { [ weak self] organizationInfo in
            let pin = MKPointAnnotation()
            pin.coordinate = organizationInfo.0
            pin.title = organizationInfo.1
            self?.mapView.mapView.addAnnotation(pin)
            self?.mapView.mapView.setRegion(MKCoordinateRegion(center: organizationInfo.0, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)), animated: true)
        }).disposed(by: disposeBag)
        
    }
    
    
}


//MARK: - Configure Search Controller and Search Bar Placeholder
extension MapController {
    
    private func configureSearchBarCancelButton() {
        let barButtonAppearanceInSearchBar: UIBarButtonItem?
        barButtonAppearanceInSearchBar = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        barButtonAppearanceInSearchBar?.image = UIImage(systemName: "xmark")?.withRenderingMode(.alwaysTemplate)
        barButtonAppearanceInSearchBar?.tintColor = .white
        barButtonAppearanceInSearchBar?.title = nil
    }
    
    private func configureSearchBarPlaceHolder(categoryType: NetworkConstants?) {
        guard let categoryType else { return }
        
        switch categoryType {
        case .hospitals:
            self.changeSearchBarProperties(title: "Hastaneler")
        case .healthCenters:
            self.changeSearchBarProperties(title: "Sağlık Ocakları")
        case .dentalCenters:
            self.changeSearchBarProperties(title: "Diş Klinikleri")
        case .pharmacy:
            self.changeSearchBarProperties(title: "Eczaneler")
        case .medicalLaboratories:
            self.changeSearchBarProperties(title: "Tıbbi Lab.")
        case .radiologyCenters:
            self.changeSearchBarProperties(title: "Radyoloji Merk.")
        case .animalHospitals:
            self.changeSearchBarProperties(title: "Hayvan Hastaneleri")
        case .psychologistCenters:
            self.changeSearchBarProperties(title: "Psikologlar")
        case .gynecologyCenters:
            self.changeSearchBarProperties(title: "Jinekoloji Merkezleri")
        case .opticCenters:
            self.changeSearchBarProperties(title: "Optik Merkezleri")
        case .privateDentalCenters:
            self.changeSearchBarProperties(title: "Ozel Diş Klinikleri")
        case .spaCenters:
            self.changeSearchBarProperties(title: "Spa Merkezleri")
        case .dialysisCenters:
            self.changeSearchBarProperties(title: "Diyaliz Merkezleri")
        case .emergencyCenters:
            self.changeSearchBarProperties(title: "Acil Servisler")
        case .medicalShopCenters:
            self.changeSearchBarProperties(title: "Medikal Alışveriş Merk.")
        case .physiotheraphyCenters:
            self.changeSearchBarProperties(title: "Fizik Tedavi Merk.")
        case .dutyPharmacy:
            self.changeSearchBarProperties(title: "Nöbetçi Eczaneler")
        }
    }
    
    private func changeSearchBarProperties(title: String) {
        let searchBarPlaceholder: String = "Bulunduğunuz şehiri arayınız..."
        self.title = title
        self.searchController?.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: searchBarPlaceholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        self.searchController?.searchBar.searchTextField.leftView?.tintColor = .white.withAlphaComponent(0.5)
    }
}
