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
    weak var mainCoordinator: MainCoordinator?
    let mainView = MainView()
    let viewModel = MainViewModel()
    
    //Dispose Bag
    private let disposeBag = DisposeBag()
    
    //MARK: - Life Cycle Methods
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
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

    }
 
    
    //MARK: - Configure ViewController
    private func configureViewController() {
        configureMainCollectionView()
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        title = "Sağlık Kuruluşları"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: mainView.navBarLeftButton)
    }
    
}

//MARK: - Configure MainCollectionView
extension MainController {
    private func configureMainCollectionView() {
        let mainCollectionDataSource = self.mainCollectionDataSource()
        
        // Bind Data mainCollectionView
        viewModel.mainCollectionData.asObservable().map { mainCollectionData -> [SectionModel<String, MainCollectionData>] in
            return [SectionModel(model: "", items: mainCollectionData)]
        }.bind(to: mainView.mainCollectionView.rx.items(dataSource: mainCollectionDataSource)).disposed(by: disposeBag)
        
        // Handle DidSelect
        mainView.mainCollectionView.rx.modelSelected(MainCollectionData.self).bind { [weak self] mainCollectionData in
            guard let self else { return }
            self.mainCoordinator?.openMapController(categoryType: mainCollectionData.categoryType, customTopViewBC: mainCollectionData.backgroundColor)
        }.disposed(by: disposeBag)
        
        
    }
    
    private func mainCollectionDataSource() -> RxCollectionViewSectionedReloadDataSource<SectionModel<String, MainCollectionData>> {
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, MainCollectionData>> { dataSource, collectionView, indexPath, mainCollectionData in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerticalCollectionCell.identifier, for: indexPath) as? VerticalCollectionCell else { return UICollectionViewCell()}
            cell.configure(with: mainCollectionData)
            return cell
        } configureSupplementaryView: { [weak self] _, collectionView, item, indexPath in
            guard let self = self, let headerView =
                    collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainCollectionHeaderView.identifier, for: indexPath) as? MainCollectionHeaderView else { return UICollectionReusableView() }
            
            // Configure Header's HorizontalCollectionView
            let headerDataSource = self.headerDataSource()
            
            
            // Bind Data to HorizontalCollectionView
            self.viewModel.horizontalCollectionData.asObservable().map { mainHorizontalCollectionData ->
                [SectionModel<String, MainHorizontalCollectionData>] in
                return [SectionModel(model: "", items: mainHorizontalCollectionData)]
            }.bind(to: headerView.horizontalCollectionView.rx.items(dataSource: headerDataSource)).disposed(by: headerView.disposeBag)
            
            // Handle DidSelect
            headerView.horizontalCollectionView.rx.modelSelected(MainHorizontalCollectionData.self).bind { [weak self] mainHorizontalCollectionData in
                guard let self else { return }
                self.mainCoordinator?.openMapController(categoryType: mainHorizontalCollectionData.categoryType, customTopViewBC: mainHorizontalCollectionData.tintAndBackgroundColor)
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
extension MainController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.height
        let cellHeight = collectionView.frame.height - 20
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    }
    
}
