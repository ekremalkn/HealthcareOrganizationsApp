//
//  SearchResultController.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 2.05.2023.
//

import UIKit
import RxSwift

final class SearchResultController: UIViewController {
    
    //MARK: - References
    private let searchResultView = SearchResultView()
    var viewModel: SearchResultViewModel?
    
    //MARK: - Variables
    var city: String?
    var county = PublishSubject<String>()
    
    //MARK: - Dispose Bag
    let disposeBag = DisposeBag()
    
    //MARK: - Lifecycle Methods
    init(categoryType: NetworkConstants) {
        self.viewModel = SearchResultViewModel(categoryType: categoryType)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .clear
        view = searchResultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    private func configureViewController() {
        configureTableView()
    }
    
    
}

//MARK: - Configure TableView
extension SearchResultController {
    private func configureTableView() {
        // Bind data
        viewModel?.cities.bind(to: searchResultView.tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { row, city, cell in
            
            switch city {
            case let city as ENCity:
                cell.textLabel?.text = city.cityName
            case let county as ENCounty:
                cell.textLabel?.text = county.cityName
            case let city as TRCity:
                cell.textLabel?.text = city.sehirAd
            case let city as TRCounty:
                cell.textLabel?.text = city.ilceAd
            default:
                return
            }
        }.disposed(by: disposeBag)
        
        // Make Request
        viewModel?.fetchCities()
        
        // Handle did select
        searchResultView.tableView.rx.modelSelected(CityModel.self).bind { [weak self] city in
            switch city {
            case let city as ENCity:
                guard let citySlug = city.citySlug else { return }
                self?.city = citySlug
                self?.viewModel?.fetchCounties(city: citySlug)
            case let county as ENCounty:
                guard let countySlug = county.citySlug else { return }
                self?.county.onNext(countySlug)
            case let city as TRCity:
                guard let citySlug = city.sehirSlug else { return }
                self?.city = citySlug
                self?.viewModel?.fetchCounties(city: citySlug)
            case let county as TRCounty:
                guard let countySlug = county.ilceSlug else { return }
                self?.county.onNext(countySlug)
            default:
                return
            }
        }.disposed(by: disposeBag)
            
        
    }
    
    
}
