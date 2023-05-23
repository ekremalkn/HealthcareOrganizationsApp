//
//  SearchResultViewModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 2.05.2023.
//

import Foundation
import RxSwift
import UIKit

final class SearchResultViewModel {
    deinit {
        print("deinit SearchResultViewModel")
    }
    //MARK: - Network Service
    var networkService: CityCountyService?

    //MARK: - Category Type
    let categoryType: NetworkConstants?
    
    //MARK: - Variables
    let citiesCounties = PublishSubject<[CityCountyModel]>()
    var cityCountyArray = [CityCountyModel]()
    var selectedCitySlug: String?
    var selectedCountySlug: String?
    var selectedCityName1: String?
    var selectedCountyName1: String?
    var selectedCountyName = PublishSubject<String>()
    var selectedCityName = BehaviorSubject<[String]>(value: [])
    var clearSearchBarText = PublishSubject<Void>()
    
    let fetchingCities = PublishSubject<Bool>()
    let fetchedCities = PublishSubject<Void>()
    let errorMsg = PublishSubject<String>()
    
    //MARK: - Dispose Bag
    private let disposeBag = DisposeBag()
        
    //MARK: - TableView Configures
    let configureTableViewCell = PublishSubject<(UITableViewCell, cityCountyName: String?)>()
    let tableViewCellSelected = PublishSubject<CityCountyModel>()
    let tableViewCellDeselected = PublishSubject<IndexPath>()
    
    let configureSelectedCollectionCell = PublishSubject<(SelectedCityCountyCell, cityCountyName: String)>()
    let selectedCollectionCellSelected = PublishSubject<Void>()
    //MARK: - Init Methods
    init(categoryType: NetworkConstants, networkService: CityCountyService) {
        self.categoryType = categoryType
        self.networkService = networkService
    }
    
   
    
}

//MARK: - View Proccess
extension SearchResultViewModel {
    //MARK: - Configure TableView
    func configureTableView(tableView: UITableView) {
        // Bind data
        citiesCounties.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { [weak self] row, cityCounty, cell in
            cell.backgroundColor = .clear
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = .systemFont(ofSize: 17)
            self?.configureTableViewCell.onNext((cell, cityCountyName: cityCounty.name))
        }.disposed(by: disposeBag)
        
        // Make Request
        fetchCities()
        
        // Handle did select
        tableView.rx.modelSelected(CityCountyModel.self).bind { [weak self] cityCounty in
            guard let self, let name = cityCounty.name, let slugName = cityCounty.slugName else { return }

            switch cityCounty.type {
            case .city:
                self.selectedCitySlug = slugName
                self.selectedCityName1 = name
                self.selectedCityName.onNext([name])
                self.tableViewCellSelected.onNext(cityCounty)
            case .county:
                self.selectedCountySlug = slugName
                self.selectedCountyName1 = name
                self.selectedCountyName.onNext(name)
                self.tableViewCellSelected.onNext(cityCounty)
            }
        }.disposed(by: disposeBag)
        
       tableView.rx.itemSelected.subscribe { [weak self] indexPath in
           guard let self else { return }
           self.tableViewCellDeselected.onNext(indexPath)
        }.disposed(by: disposeBag)

    }
    
    //MARK: - Configure Selected Collection View
    func configureSelectedCollectionView(collectionView: UICollectionView, searchResultController: SearchResultController) {
        // Bind data
        selectedCityName.bind(to: collectionView.rx.items(cellIdentifier: SelectedCityCountyCell.identifier, cellType: SelectedCityCountyCell.self)) { [weak self] row, cityCountyName, cell in
            self?.configureSelectedCollectionCell.onNext((cell, cityCountyName: cityCountyName))
        }.disposed(by: disposeBag)
        
        
        // Handle Did Select
        collectionView.rx.itemSelected.subscribe { [weak self] indexPath in
            guard let self else { return }
            self.deleteSelectedItem(indexPath: indexPath) { [weak self] selectedItems  in
                guard let self, let selectedItems else { return }
                self.clearSearchBarText.onNext(())
                self.selectedCityName.onNext(selectedItems)
                self.fetchCities()
                self.selectedCollectionCellSelected.onNext(())

            }
        }.disposed(by: disposeBag)
        
        // Set delegate for cell size
        collectionView.rx.setDelegate(searchResultController).disposed(by: disposeBag)
    }
    
    private func deleteSelectedItem(indexPath: IndexPath, completion: (([String]?) -> Void)) {
        var data = try? self.selectedCityName.value()
        data?.remove(at: indexPath.row)
        completion(data)
    }
    
    func calculateSelectedCollectionCellSize(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = collectionView.frame.height / 2 + 10
        var cellWidth = collectionView.frame.width / 3
        let cellPadding: CGFloat = 15
        
        // Dynamic cell width according to label text length
        do {
            let citiesCounties = try? selectedCityName.value()
            guard let citiesCounties else { return CGSize() }
            let cityCountyName = citiesCounties[indexPath.row]
            let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: 15)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedsize = NSString(string: cityCountyName).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)], context: nil)
            let width = estimatedsize.width + cellPadding * 2
            cellWidth = width + 30 // xImageView width
            return CGSize(width: cellWidth, height: cellHeight)
        }
    }

}


//MARK: - Network Process
extension SearchResultViewModel {
    //MARK: - Handle City Event
    private func handleTRCityModel(_ event: Event<TRCityModel?> ) {
        switch event {
        case .next(let cities):
            guard let cities = cities?.data else { return }
            self.setLoadingAnimateState(fetchingCities: false, fetchedCities: (), errorMsg: nil)
            self.citiesCounties.onNext(cities)
            self.cityCountyArray = cities
        case .error(let error):
            self.setLoadingAnimateState(fetchingCities: nil, fetchedCities: nil, errorMsg: error.localizedDescription)
        case .completed:
            print("success")
        }
        
    }
    
    private func handleENCityModel(_ event: Event<ENCityModel?>) {
        switch event {
        case .next(let cities):
            guard let cities = cities?.data else { return }
            self.setLoadingAnimateState(fetchingCities: false, fetchedCities: (), errorMsg: nil)
            self.citiesCounties.onNext(cities)
            self.cityCountyArray = cities
        case .error(let error):
            self.setLoadingAnimateState(fetchingCities: nil, fetchedCities: nil, errorMsg: error.localizedDescription)
        case .completed:
            print("success")
        }
    }
    
    //MARK: - Fetch Cities
    func fetchCities() {
        guard let categoryType, let networkService else { return }
        self.setLoadingAnimateState(fetchingCities: true)
        
        switch categoryType {
        case .hospitals:
            networkService.getTRCities(type: categoryType).subscribe { [weak self] event in
                self?.handleTRCityModel(event)
            }.disposed(by: disposeBag)
        case .healthCenters:
            networkService.getTRCities(type: categoryType).subscribe { [weak self] event in
                self?.handleTRCityModel(event)
            }.disposed(by: disposeBag)
        case .dentalCenters:
            networkService.getENCities(type: categoryType).subscribe { [weak self] event in
                self?.handleENCityModel(event)
            }.disposed(by: disposeBag)
        case .pharmacy:
            networkService.getTRCities(type: categoryType).subscribe { [weak self] event in
                self?.handleTRCityModel(event)
            }.disposed(by: disposeBag)
        case .medicalLaboratories:
            networkService.getTRCities(type: categoryType).subscribe { [weak self] event in
                self?.handleTRCityModel(event)
            }.disposed(by: disposeBag)
        case .radiologyCenters:
            networkService.getTRCities(type: categoryType).subscribe { [weak self] event in
                self?.handleTRCityModel(event)
            }.disposed(by: disposeBag)
        case .animalHospitals:
            networkService.getENCities(type: categoryType).subscribe { [weak self] event in
                self?.handleENCityModel(event)
            }.disposed(by: disposeBag)
        case .psychologistCenters:
            networkService.getENCities(type: categoryType).subscribe { [weak self] event in
                self?.handleENCityModel(event)
            }.disposed(by: disposeBag)
        case .gynecologyCenters:
            networkService.getENCities(type: categoryType).subscribe { [weak self] event in
                self?.handleENCityModel(event)
            }.disposed(by: disposeBag)
        case .opticCenters:
            networkService.getENCities(type: categoryType).subscribe { [weak self] event in
                self?.handleENCityModel(event)
            }.disposed(by: disposeBag)
        case .privateDentalCenters:
            networkService.getENCities(type: categoryType).subscribe { [weak self] event in
                self?.handleENCityModel(event)
            }.disposed(by: disposeBag)
        case .spaCenters:
            networkService.getENCities(type: categoryType).subscribe { [weak self] event in
                self?.handleENCityModel(event)
            }.disposed(by: disposeBag)
        case .dialysisCenters:
            networkService.getENCities(type: categoryType).subscribe { [weak self] event in
                self?.handleENCityModel(event)
            }.disposed(by: disposeBag)
        case .emergencyCenters:
            networkService.getENCities(type: categoryType).subscribe { [weak self] event in
                self?.handleENCityModel(event)
            }.disposed(by: disposeBag)
        case .medicalShopCenters:
            networkService.getENCities(type: categoryType).subscribe { [weak self] event in
                self?.handleENCityModel(event)
            }.disposed(by: disposeBag)
        case .physiotheraphyCenters:
            networkService.getENCities(type: categoryType).subscribe { [weak self] event in
                self?.handleENCityModel(event)
            }.disposed(by: disposeBag)
        case .dutyPharmacy:
            networkService.getTRCities(type: categoryType).subscribe { [weak self] event in
                self?.handleTRCityModel(event)
            }.disposed(by: disposeBag)
        }
    }
    
    
    //MARK: - Handle County Event
    private func handleTRCountyModel(_ event: Event<TRCountyModel?> ) {
        switch event {
        case .next(let counties):
            guard let counties = counties?.data else { return }
            self.setLoadingAnimateState(fetchingCities: false, fetchedCities: (), errorMsg: nil)
            self.citiesCounties.onNext(counties)
            self.cityCountyArray = counties
        case .error(let error):
            self.setLoadingAnimateState(fetchingCities: nil, fetchedCities: nil, errorMsg: error.localizedDescription)
        case .completed:
            print("success")
        }
    }
    
    private func handleENCountyModel(_ event: Event<ENCountyModel?>) {
        switch event {
        case .next(let counties):
            guard let counties = counties?.data else { return }
            self.setLoadingAnimateState(fetchingCities: false, fetchedCities: (), errorMsg: nil)
            self.citiesCounties.onNext(counties)
            self.cityCountyArray = counties
        case .error(let error):
            self.setLoadingAnimateState(fetchingCities: nil, fetchedCities: nil, errorMsg: error.localizedDescription)
        case .completed:
            print("success")
        }
    }
    
    //MARK: - Fetch Counties
    func fetchCounties(city: String) {
        guard let categoryType, let networkService else { return }
        
        switch categoryType {
        case .hospitals:
            networkService.getTRCounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleTRCountyModel(event)
            }.disposed(by: disposeBag)
        case .healthCenters:
            networkService.getTRCounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleTRCountyModel(event)
            }.disposed(by: disposeBag)
        case .dentalCenters:
            networkService.getENcounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleENCountyModel(event)
            }.disposed(by: disposeBag)
        case .pharmacy:
            networkService.getTRCounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleTRCountyModel(event)
            }.disposed(by: disposeBag)
        case .medicalLaboratories:
            networkService.getTRCounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleTRCountyModel(event)
            }.disposed(by: disposeBag)
        case .radiologyCenters:
            networkService.getTRCounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleTRCountyModel(event)
            }.disposed(by: disposeBag)
        case .animalHospitals:
            networkService.getENcounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleENCountyModel(event)
            }.disposed(by: disposeBag)
        case .psychologistCenters:
            networkService.getENcounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleENCountyModel(event)
            }.disposed(by: disposeBag)
        case .gynecologyCenters:
            networkService.getENcounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleENCountyModel(event)
            }.disposed(by: disposeBag)
        case .opticCenters:
            networkService.getENcounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleENCountyModel(event)
            }.disposed(by: disposeBag)
        case .privateDentalCenters:
            networkService.getENcounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleENCountyModel(event)
            }.disposed(by: disposeBag)
        case .spaCenters:
            networkService.getENcounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleENCountyModel(event)
            }.disposed(by: disposeBag)
        case .dialysisCenters:
            networkService.getENcounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleENCountyModel(event)
            }.disposed(by: disposeBag)
        case .emergencyCenters:
            networkService.getENcounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleENCountyModel(event)
            }.disposed(by: disposeBag)
        case .medicalShopCenters:
            networkService.getENcounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleENCountyModel(event)
            }.disposed(by: disposeBag)
        case .physiotheraphyCenters:
            networkService.getENcounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleENCountyModel(event)
            }.disposed(by: disposeBag)
        case .dutyPharmacy:
            networkService.getTRCounties(type: categoryType, city: city).subscribe { [weak self] event in
                self?.handleTRCountyModel(event)
            }.disposed(by: disposeBag)
        }
    }
    
    //MARK: - Filter Cities / Counties
    func filterCityCounty(character: String) {
        let filteredCitiesCounties = cityCountyArray.filter { cityModel in
            switch cityModel {
            case let city as ENCity:
                guard let cityName = city.cityName else { return false }
                return cityName.lowercased().hasPrefix(character.lowercased())
            case let county as ENCounty:
                guard let countyName = county.cityName else { return false}
                return countyName.lowercased().hasPrefix(character.lowercased())
            case let city as TRCity:
                guard let cityName = city.sehirAd else { return false}
                return cityName.lowercased().hasPrefix(character.lowercased())
            case let county as TRCounty:
                guard let countyName = county.ilceAd else { return false}
                return countyName.lowercased().hasPrefix(character.lowercased())
            default:
                return false
            }
        }
        
        self.citiesCounties.onNext(filteredCitiesCounties)
        
    }
    
    //MARK: - Set Loading Animate State
    private func setLoadingAnimateState(fetchingCities: Bool? = nil, fetchedCities: Void? = nil, errorMsg: String? = nil) {
        if let fetchingCities {
            self.fetchingCities.onNext(fetchingCities)
        } else if let fetchedCities {
            self.fetchedCities.onNext(fetchedCities)
        } else if let errorMsg {
            self.errorMsg.onNext(errorMsg)
        }
    }
    
    
}
