//
//  MainViewModel.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 22.04.2023.
//

import UIKit
import RxSwift
import RxDataSources

final class MainViewModel {
    
    //MARK: - DisposeBag
    private let disposeBag = DisposeBag()
    
    
    //MARK: - CollectionView Datas
    let horizontalCollectionData = Observable.just([
        MainHorizontalCollectionData.categoryType(.dutyPharmacy),
        MainHorizontalCollectionData.categoryType(.hospitals),
        MainHorizontalCollectionData.categoryType(.dentalCenters),
        MainHorizontalCollectionData.categoryType(.healthCenters)
    ])
    
    let mainCollectionData = Observable.just([
        MainCollectionData.categoryType(.hospitals),
        MainCollectionData.categoryType(.healthCenters),
        MainCollectionData.categoryType(.dentalCenters),
        MainCollectionData.categoryType(.pharmacy),
        MainCollectionData.categoryType(.dutyPharmacy),
        MainCollectionData.categoryType(.dialysisCenters),
        MainCollectionData.categoryType(.physiotheraphyCenters),
        MainCollectionData.categoryType(.privateDentalCenters),
        MainCollectionData.categoryType(.opticCenters),
        MainCollectionData.categoryType(.emergencyCenters),
        MainCollectionData.categoryType(.medicalShopCenters),
        MainCollectionData.categoryType(.spaCenters),
        MainCollectionData.categoryType(.medicalLaboratories),
        MainCollectionData.categoryType(.radiologyCenters),
        MainCollectionData.categoryType(.animalHospitals),
        MainCollectionData.categoryType(.psychologistCenters),
        MainCollectionData.categoryType(.gynecologyCenters)
    ])
    
    let horizontalCollectionCellSelected = PublishSubject<(categoryType: NetworkConstants, customTopViewBC: UIColor)>()
    let verticalCollectionCellSelected = PublishSubject<(categoryType: NetworkConstants, customTopViewBC: UIColor)>()
    let configureHorizontalCollectionCell = PublishSubject<(HorizontalCollectionCell, MainHorizontalCollectionData)>()
    let configureVerticalCollectionCell = PublishSubject<(VerticalCollectionCell, MainCollectionData)>()
    
}

//MARK: - Configure CollectionView
extension MainViewModel {
    func configureMainCollectionView(mainView: MainView, viewController: MainController) {
        let mainCollectionDataSource = self.mainCollectionDataSource(viewController: viewController)
        
        // Bind Data mainCollectionView
        mainCollectionData.asObservable().map { mainCollectionData -> [SectionModel<String, MainCollectionData>] in
            return [SectionModel(model: "", items: mainCollectionData)]
        }.bind(to: mainView.mainCollectionView.rx.items(dataSource: mainCollectionDataSource)).disposed(by: disposeBag)
        
        // Handle DidSelect
        mainView.mainCollectionView.rx.modelSelected(MainCollectionData.self).bind { [weak self] mainCollectionData in
            guard let self else { return }
            self.verticalCollectionCellSelected.onNext((categoryType: mainCollectionData.selectedCategoryType, customTopViewBC: mainCollectionData.backgroundColor))
        }.disposed(by: disposeBag)
        
    }
    
    private func mainCollectionDataSource(viewController: MainController) -> RxCollectionViewSectionedReloadDataSource<SectionModel<String, MainCollectionData>> {
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, MainCollectionData>> { [weak self] dataSource, collectionView, indexPath, mainCollectionData in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerticalCollectionCell.identifier, for: indexPath) as? VerticalCollectionCell else { return UICollectionViewCell()}
            self?.configureVerticalCollectionCell.onNext((cell, mainCollectionData))
            return cell
        } configureSupplementaryView: { [weak self] _, collectionView, item, indexPath in
            guard let self = self, let headerView =
                    collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainCollectionHeaderView.identifier, for: indexPath) as? MainCollectionHeaderView else { return UICollectionReusableView() }
            
            // Configure Header's HorizontalCollectionView
            let headerDataSource = self.headerDataSource()
            
            
            // Bind Data to HorizontalCollectionView
            horizontalCollectionData.asObservable().map { mainHorizontalCollectionData ->
                [SectionModel<String, MainHorizontalCollectionData>] in
                return [SectionModel(model: "", items: mainHorizontalCollectionData)]
            }.bind(to: headerView.horizontalCollectionView.rx.items(dataSource: headerDataSource)).disposed(by: headerView.disposeBag)
            
            // Handle DidSelect
            headerView.horizontalCollectionView.rx.modelSelected(MainHorizontalCollectionData.self).bind { [weak self] mainHorizontalCollectionData in
                guard let self else { return }
                self.horizontalCollectionCellSelected.onNext((categoryType: mainHorizontalCollectionData.selectedCategoryType, customTopViewBC: mainHorizontalCollectionData.tintAndBackgroundColor))
            }.disposed(by: headerView.disposeBag)
            
            // Delegate for horizontalCollection cell size
            headerView.horizontalCollectionView.rx.setDelegate(viewController).disposed(by: headerView.disposeBag)
            
            return headerView
        }
        return dataSource
    }
    
    private func headerDataSource() -> RxCollectionViewSectionedReloadDataSource<SectionModel<String, MainHorizontalCollectionData>> {
        let headerDataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, MainHorizontalCollectionData>> (configureCell: { [weak self] dataSource, collectionView, indexPath, horizontalCollectionData in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalCollectionCell.identifier, for: indexPath) as? HorizontalCollectionCell else { return UICollectionViewCell() }
            self?.configureHorizontalCollectionCell.onNext((cell, horizontalCollectionData))
            return cell
        } )
        
        return headerDataSource
    }
}

//MARK: - Set CollectionView Cell Size
extension MainViewModel {
    func calculateCellSize(_ view: MainView, _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == view.mainCollectionView {
            
        } else {
            let cellWidth = collectionView.frame.height
            let cellHeight = collectionView.frame.height - 20
            return CGSize(width: cellWidth, height: cellHeight)
        }
        return CGSize()
    }
}

//MARK: - Padding collection cell
extension MainViewModel {
    func addPaddingToHorizontalCells(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    }
}
