//
//  MainController.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 21.04.2023.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

final class MainController: UIViewController {
    
    //MARK: - References
    var mainCoordinator: MainCoordinator?
    let mainView = MainView()
    let viewModel: MainViewModel
    
    //Dispose Bag
    private let disposeBag = DisposeBag()
    
    private var isUserSubscribe: Bool = false
    
    //MARK: - Life Cycle Methods
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavItems()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        checkUserSubscriptionStatus()
    }
    
    
    //MARK: - Configure ViewController
    private func configureViewController() {
        configureMainCollectionView()
    }
    
    private func configureNavItems() {
        title = "Sağlık Kuruluşları"
        navigationController?.navigationBar.barTintColor = .init(hex: "FBFCFE")
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0.3
        navigationController?.navigationBar.layer.shadowOffset = CGSize.init(width: 2, height: 2)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: mainView.navBarLeftButton)
        navigationItem.backBarButtonItem = mainView.backButton
        subsToLeftNavBarButton()
    }
    
    //MARK: - Check User Subscription Status
    private func checkUserSubscriptionStatus() {
        viewModel.checkSubscriptionStatus().subscribe { [weak self] isUserSubscribe in
            guard let self else { return }
            self.isUserSubscribe = isUserSubscribe
        }.disposed(by: disposeBag)
        
    }
    
    //MARK: - Left Nav Bar Button Action
    private func subsToLeftNavBarButton() {
        mainView.navBarLeftButton.rx.tap.subscribe { [weak self] _ in
            guard let self else { return }
            self.mainCoordinator?.openSideMenu(from: self)
        }.disposed(by: disposeBag)
    }
    
    
}

//MARK: - Configure CollectionView
extension MainController {
    func configureMainCollectionView() {
        let mainCollectionDataSource = self.mainCollectionDataSource()
        
        // Bind Data mainCollectionView
        viewModel.mainCollectionData.asObservable().map { mainCollectionData -> [SectionModel<String, MainCollectionData>] in
            return [SectionModel(model: "", items: mainCollectionData)]
        }.bind(to: mainView.mainCollectionView.rx.items(dataSource: mainCollectionDataSource)).disposed(by: disposeBag)
        
        // Handle DidSelect
        mainView.mainCollectionView.rx.modelSelected(MainCollectionData.self).bind { [weak self] mainCollectionData in
            guard let self else { return }
            let elementToCheck = mainCollectionData.selectedCategoryType
            let isSelectedCategoryFree = viewModel.freeMainCollectionCategories.contains { $0.selectedCategoryType == elementToCheck }
            
            if isSelectedCategoryFree {
                mainCoordinator?.openMap(categoryType: mainCollectionData.selectedCategoryType, cellType: mainCollectionData.cellTypeAccorindToCategory, customTopViewBC: .init(hex: mainCollectionData.backgroundColor))
            } else {
                !isUserSubscribe ? mainCoordinator?.openPayWall() : mainCoordinator?.openMap(categoryType: mainCollectionData.selectedCategoryType, cellType: mainCollectionData.cellTypeAccorindToCategory, customTopViewBC: .init(hex: mainCollectionData.backgroundColor))
            }
            
            
            
        }.disposed(by: disposeBag)
        
        
        mainView.mainCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    private func mainCollectionDataSource() -> RxCollectionViewSectionedReloadDataSource<SectionModel<String, MainCollectionData>> {
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, MainCollectionData>> { dataSource, collectionView, indexPath, mainCollectionData in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerticalCollectionCell.identifier, for: indexPath) as? VerticalCollectionCell else { return UICollectionViewCell()}
            cell.configure(with: mainCollectionData)
            return cell
        } configureSupplementaryView: { [weak self] _, collectionView, item, indexPath in
            guard let self = self, let headerView =
                    collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainCollectionHeaderView.identifier, for: indexPath) as? MainCollectionHeaderView else { return UICollectionReusableView() }
            
            
            headerView.textField.tapGestureRecognizer.rx.event.subscribe { [weak self] _ in
                guard let self else { return }
                mainCoordinator?.openSelection()
            }.disposed(by: disposeBag)
            
            // Configure Header's HorizontalCollectionView
            let headerDataSource = self.headerDataSource()
            
            
            // Bind Data to HorizontalCollectionView
            viewModel.horizontalCollectionData.asObservable().map { mainHorizontalCollectionData ->
                [SectionModel<String, MainHorizontalCollectionData>] in
                return [SectionModel(model: "", items: mainHorizontalCollectionData)]
            }.bind(to: headerView.horizontalCollectionView.rx.items(dataSource: headerDataSource)).disposed(by: headerView.disposeBag)
            
            // Handle DidSelect
            headerView.horizontalCollectionView.rx.modelSelected(MainHorizontalCollectionData.self).bind { [weak self] mainHorizontalCollectionData in
                guard let self else { return }
                
                let elementToCheck = mainHorizontalCollectionData.selectedCategoryType
                let isSelectedCategoryFree = viewModel.freeHorizontalCollectionCategories.contains { $0.selectedCategoryType == elementToCheck }
                
                if isSelectedCategoryFree {
                    mainCoordinator?.openMap(categoryType: mainHorizontalCollectionData.selectedCategoryType, cellType: mainHorizontalCollectionData.cellTypeAccorindToCategory, customTopViewBC: .init(hex: mainHorizontalCollectionData.tintAndBackgroundColor))
                } else {
                    !isUserSubscribe ? mainCoordinator?.openPayWall() : mainCoordinator?.openMap(categoryType: mainHorizontalCollectionData.selectedCategoryType, cellType: mainHorizontalCollectionData.cellTypeAccorindToCategory, customTopViewBC: .init(hex: mainHorizontalCollectionData.tintAndBackgroundColor))
                }
                
            }.disposed(by: headerView.disposeBag)
            
            // Delegate for horizontalCollection cell size
            headerView.horizontalCollectionView.rx.setDelegate(self).disposed(by: headerView.disposeBag)
            
            return headerView
        }
        return dataSource
    }
    
    private func headerDataSource() -> RxCollectionViewSectionedReloadDataSource<SectionModel<String, MainHorizontalCollectionData>> {
        let headerDataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, MainHorizontalCollectionData>> (configureCell: { dataSource, collectionView, indexPath, horizontalCollectionData in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalCollectionCell.identifier, for: indexPath) as? HorizontalCollectionCell else { return UICollectionViewCell() }
            cell.configure(with: horizontalCollectionData)
            return cell
        } )
        
        return headerDataSource
    }
}

//MARK: - Configure Header's HorizontalCollectionView Cell Size / Padding
extension MainController: UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == mainView.mainCollectionView {
            
        } else {
            let cellWidth = collectionView.frame.height
            let cellHeight = collectionView.frame.height - 20
            return CGSize(width: cellWidth, height: cellHeight)
        }
        return CGSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    }
    
    
}


