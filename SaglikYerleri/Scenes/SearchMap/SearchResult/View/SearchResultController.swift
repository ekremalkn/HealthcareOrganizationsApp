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
    var tableCollectionAnimateState: SearchResultAnimateState = .toBottom
    var searchControllerViewDidAppear = PublishSubject<Void>()
    var searchControllerDissmissed = PublishSubject<(String, String, String, String)>()
    
    //MARK: - Dispose Bag
    let disposeBag = DisposeBag()
    let backgroundColor: UIColor
    
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
        searchResultView.tableView.backgroundColor = backgroundColor.withAlphaComponent(0.8)
        configureTableView()
        configureTableViewCellSelections()
        
        configureSelectedCollectionView()
        configureSelectedCollectionSelections()
        
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
        searchResultView.tableView.rx.modelSelected(CityCountyModel.self).bind { [weak self] cityCounty in
            guard let self, let viewModel else { return }
            viewModel.tableViewSelecteCityCounty(model: cityCounty)
        }.disposed(by: disposeBag)
        
        searchResultView.tableView.rx.itemSelected.subscribe { [weak self] indexPath in
            guard let self else { return }
            self.searchResultView.tableView.deselectRow(at: indexPath, animated: true)
        }.disposed(by: disposeBag)
        
    }
}

//MARK: - TableViewSelections
extension SearchResultController {
    private func configureTableViewCellSelections() {
        viewModel?.tableViewCellSelected.subscribe(onNext: { [weak self] selection in
            guard let self else { return }
            switch selection.type {
                
            case .city:
                guard let slugName = selection.slugName else { return }
                searchResultView.needSelectedItemCollectionView(animateState: self.tableCollectionAnimateState) { [weak self] in
                    guard let self else { return }
                    self.viewModel?.fetchCounties(city: slugName)
                }
            case .county:
                self.dismiss(animated: true) { [weak self] in
                    guard let self else { return }
                    guard let selectedCitySlug = self.viewModel?.selectedCitySlug, let selectedCountySlug = self.viewModel?.selectedCountySlug else { return }
                    if let selectedCityName = self.viewModel?.selectedCityName1, let selectedCountyName = self.viewModel?.selectedCountyName1 {
                        self.searchControllerDissmissed.onNext((selectedCitySlug, selectedCountySlug, selectedCityName, selectedCountyName))
                    } else {
                        self.searchControllerDissmissed.onNext((selectedCitySlug, selectedCountySlug, "", ""))
                    }
                }
            }
        }).disposed(by: disposeBag)
        
    }
    
    
}
//MARK: - Configure Selected Collection View
extension SearchResultController {
    func configureSelectedCollectionView() {
        guard let viewModel else { return }
        // Bind data
        viewModel.selectedCityName.bind(to: searchResultView.selectedCityCountyCollectionView.rx.items(cellIdentifier: SelectedCityCountyCell.identifier, cellType: SelectedCityCountyCell.self)) { row, cityCountyName, cell in
            cell.configure(cityCountyName)
        }.disposed(by: disposeBag)
        
        
        // Handle Did Select
        searchResultView.selectedCityCountyCollectionView.rx.itemSelected.subscribe { [weak self] indexPath in
            guard let self else { return }
            self.viewModel?.deleteSelectedItem(indexPath: indexPath)
        }.disposed(by: disposeBag)
        
        // Set delegate for cell size
        searchResultView.selectedCityCountyCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
}


//MARK: - CollectionViewSelections and Configure Cell
extension SearchResultController {
    private func configureSelectedCollectionSelections() {
        viewModel?.selectedCollectionCellSelected.subscribe(onNext: { [weak self] _ in
            guard let self else { return }
            self.searchResultView.needSelectedItemCollectionView(animateState: .toTop) { [weak self] in
                guard let self else { return }
                self.tableCollectionAnimateState = .toBottom
            }
        }).disposed(by: disposeBag)
    }
}



//MARK: - Configure Selected CollectionView
extension SearchResultController: UICollectionViewDelegateFlowLayout {
    
    // Configure Cell Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = collectionView.frame.height / 2 + 10
        var cellWidth = collectionView.frame.width / 3
        let cellPadding: CGFloat = 15
        
        do {
            let citiesCounties = try? viewModel?.selectedCityName.value()
            guard let citiesCounties else { return CGSize() }
            let cityCountyName = citiesCounties[indexPath.row]
            let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: 15)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedsize = NSString(string: cityCountyName).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)], context: nil)
            let width = estimatedsize.width + cellPadding * 2
            cellWidth = width + 30
            return CGSize(width: cellWidth, height: cellHeight)
        }
        
        // Dynamic cell width according to label text length
    }
    
    
}
