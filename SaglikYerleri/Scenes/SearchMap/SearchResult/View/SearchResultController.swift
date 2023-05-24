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
        
        configureTableViewCells()
        viewModel?.configureTableView(tableView: searchResultView.tableView)
        configureTableViewCellSelections()
        
        configureSelectedCollectionCells()
        viewModel?.configureSelectedCollectionView(collectionView: searchResultView.selectedCityCountyCollectionView, searchResultController: self)
        configureSelectedCollectionSelections()

    }
    
    
}


//MARK: - TableViewSelections and Configure Cell
extension SearchResultController {
    private func configureTableViewCells() {
        viewModel?.configureTableViewCell.subscribe(onNext: { cell, cityCountyName in
            cell.textLabel?.text = cityCountyName
        }).disposed(by: disposeBag)
    }
    
    private func configureTableViewCellSelections() {
        viewModel?.tableViewCellSelected.subscribe(onNext: { [weak self] selection in
            guard let self else { return }
            switch selection.type {
                
            case .city:
                guard let slugName = selection.name else { return }
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
        
        viewModel?.tableViewCellDeselected.subscribe(onNext: { [weak self] indexPath in
            guard let self else { return }
            self.searchResultView.tableView.deselectRow(at: indexPath, animated: true)
        }).disposed(by: disposeBag)
    }
    
    
}


//MARK: - CollectionViewSelections and Configure Cell
extension SearchResultController {
    private func configureSelectedCollectionCells() {
        viewModel?.configureSelectedCollectionCell.subscribe(onNext: { cell, cityCountyName in
            cell.configure(cityCountyName)
        }).disposed(by: disposeBag)
    }
    
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
        guard let viewModel else { return CGSize() }
        let cellSize = viewModel.calculateSelectedCollectionCellSize(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath)
        
        return cellSize
        
    }
    
    
}
