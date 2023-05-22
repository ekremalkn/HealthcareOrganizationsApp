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
    var selectedCitySlug: String?
    var selectedCountySlug: String?
    var selectedCityName1: String?
    var selectedCountyName1: String?
    var selectedCountyName = PublishSubject<String>()
    var selectedCityName = BehaviorSubject<[String]>(value: [])
    var tableCollectionAnimateState: SearchResultAnimateState = .toBottom
    var searchControllerViewDidAppear = PublishSubject<Void>()
    var searchControllerDissmissed = PublishSubject<(String, String, String, String)>()
    var clearSearchBarText = PublishSubject<Void>()
    
    //MARK: - Dispose Bag
    let disposeBag = DisposeBag()
    let backgroundColor: UIColor?
    
    //MARK: - Lifecycle Methods
    init(categoryType: NetworkConstants, networkService: CityCountyService, backgroundColor: UIColor) {
        self.viewModel = SearchResultViewModel(categoryType: categoryType, networkService: networkService)
        self.backgroundColor = backgroundColor
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.searchControllerViewDidAppear.onNext(())
    }
    
    private func configureViewController() {
        if let backgroundColor {
            searchResultView.tableView.backgroundColor = backgroundColor.withAlphaComponent(0.8)
        }
        configureTableView()
        configureSelectedCollectionView()
    }
    
    
}


//MARK: - Configure TableView
extension SearchResultController {
    private func configureTableView() {
        // Bind data
        viewModel?.citiesCounties.bind(to: searchResultView.tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { row, cityCounty, cell in
            cell.backgroundColor = .clear
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = .systemFont(ofSize: 17)
            cell.textLabel?.text = cityCounty.name
        }.disposed(by: disposeBag)
        
        // Make Request
        viewModel?.fetchCities()
        
        // Handle did select
        searchResultView.tableView.rx.modelSelected(CityCountyModel.self).bind { [weak self] city in
            guard let self, let name = city.name, let slugName = city.slugName else { return }
            switch city.type {
            case .city:
                self.selectedCitySlug = slugName
                self.selectedCityName1 = name
                self.selectedCityName.onNext([name])
                self.searchResultView.needSelectedItemCollectionView(animateState: self.tableCollectionAnimateState) { [weak self] in
                    self?.viewModel?.fetchCounties(city: slugName)
                }
            case .county:
                self.selectedCountySlug = slugName
                self.selectedCountyName1 = name
                self.selectedCountyName.onNext(name)
                self.dismiss(animated: true) { [weak self] in
                    guard let selectedCitySlug = self?.selectedCitySlug, let selectedCountySlug = self?.selectedCountySlug else { return }
                    if let selectedCityName = self?.selectedCityName1, let selectedCountyName = self?.selectedCountyName1 {
                        self?.searchControllerDissmissed.onNext((selectedCitySlug, selectedCountySlug, selectedCityName, selectedCountyName))
                    } else {
                        self?.searchControllerDissmissed.onNext((selectedCitySlug, selectedCountySlug, "", ""))
                    }
                }
            }
            
        }.disposed(by: disposeBag)
        
        searchResultView.tableView.rx.itemSelected.subscribe { [weak self] indexPath in
            self?.searchResultView.tableView.deselectRow(at: indexPath, animated: true)
        }.disposed(by: disposeBag)

    }
    
    
}

//MARK: - Configure Selected CollectionView
extension SearchResultController: UICollectionViewDelegateFlowLayout {
    private func configureSelectedCollectionView() {
        // Bind data
        selectedCityName.bind(to: self.searchResultView.selectedCityCountyCollectionView.rx.items(cellIdentifier: SelectedCityCountyCell.identifier, cellType: SelectedCityCountyCell.self)) { row, cityCountyName, cell in
            cell.configure(cityCountyName)
        }.disposed(by: disposeBag)
        
        
        // Handle Did Select
        searchResultView.selectedCityCountyCollectionView.rx.itemSelected.subscribe { [weak self] indexPath in
            guard let self else { return }
            self.deleteSelectedItem(indexPath: indexPath) { [weak self] selectedItems  in
                guard let self, let selectedItems else { return }
                self.clearSearchBarText.onNext(())
                self.selectedCityName.onNext(selectedItems)
                self.viewModel?.fetchCities()
                self.searchResultView.needSelectedItemCollectionView(animateState: .toTop) { [weak self] in
                    self?.tableCollectionAnimateState = .toBottom
                }
                
            }
        }.disposed(by: disposeBag)
        
        // Set delegate for cell size
        searchResultView.selectedCityCountyCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    private func deleteSelectedItem(indexPath: IndexPath, completion: (([String]?) -> Void)) {
        var data = try? self.selectedCityName.value()
        data?.remove(at: indexPath.row)
        completion(data)
    }
    
    
    
    // Configure Cell Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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
