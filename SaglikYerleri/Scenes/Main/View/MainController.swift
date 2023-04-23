//
//  MainController.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 21.04.2023.
//

import UIKit
import RxCocoa
import RxSwift

final class MainController: UIViewController {
    
    //MARK: - References
    var coordinator: Coordinator?
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
    
    //MARK: - Configure ViewController
    private func configureViewController() {
        createCallbacks()
        setupDelegates()
        configureNavigationBar()
    }
    
    private func setupDelegates() {
        setupHorizontalCollectionViewDelegate()
    }
    
    private func createCallbacks() {
        configureHorizontalCollectionView()
        configureVerticalCollectionView()
    }
    
    private func configureNavigationBar() {
        title = "Sağlık Kuruluşları"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: mainView.navBarLeftButton)
    }
    
}

//MARK: - Configure HorizontalCollectionView
extension MainController: UICollectionViewDelegateFlowLayout {
    private func configureHorizontalCollectionView() {
        viewModel.horizontalCollectionData.bind(to: mainView.topView.horizontalCollectionView.rx.items(cellIdentifier: HorizontalCollectionCell.identifier, cellType: HorizontalCollectionCell.self)) { row, horizontalCollectionData, cell in
            cell.configure(with: horizontalCollectionData)
        } .disposed(by: disposeBag)
    }
    
    
    private func setupHorizontalCollectionViewDelegate() {
        mainView.topView.horizontalCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == mainView.topView.horizontalCollectionView {
            let cellWidth = collectionView.frame.height
            let cellHeight = collectionView.frame.height - 20
            return CGSize(width: cellWidth, height: cellHeight)
        }
        return CGSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
    }
    
}

//MARK: - Configure VerticalCollectionView
extension MainController {
    private func configureVerticalCollectionView() {
        viewModel.verticalCollectionData.bind(to: mainView.verticalCollectionView.rx.items(cellIdentifier: VerticalCollectionCell.identifier, cellType: VerticalCollectionCell.self)) { row, verticalCollectionData, cell in
            cell.configure(with: verticalCollectionData)
        }.disposed(by: disposeBag)
    }
}
