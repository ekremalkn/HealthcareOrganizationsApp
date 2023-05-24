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
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
    }
    
    
    //MARK: - Configure ViewController
    private func configureViewController() {
        configureNavigationBar()
        configureLeftNavButton()
        configureCell()
        viewModel.configureMainCollectionView(mainView: mainView, viewController: self)
        configureCollectionViewSelections()

    }
    
    private func configureNavigationBar() {
        title = "Sağlık Kuruluşları"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: mainView.navBarLeftButton)
    }
    
}

//MARK: - Configiure Cell
extension MainController {
    private func configureCell() {
        viewModel.configureHorizontalCollectionCell.subscribe { horizontalCell, horizontalData in
            horizontalCell.configure(with: horizontalData)
        }.disposed(by: disposeBag)
        
        viewModel.configureVerticalCollectionCell.subscribe { verticalCell, verticalData in
            verticalCell.configure(with: verticalData)
        }.disposed(by: disposeBag)
    }
}

//MARK: - Button Taps
extension MainController {
    private func configureLeftNavButton() {
        mainView.navBarLeftButton.rx.tap.subscribe { [weak self] _ in
            guard let self else { return }
            self.mainCoordinator?.openSideMenuController(from: self)
        }.disposed(by: disposeBag)
    }
    
    private func configureCollectionViewSelections() {
        viewModel.horizontalCollectionCellSelected.subscribe { [weak self] categoryType, customTopViewBC in
            guard let self else { return }
            self.mainCoordinator?.openMapController(categoryType: categoryType, customTopViewBC: customTopViewBC)
        }.disposed(by: disposeBag)
        
        viewModel.verticalCollectionCellSelected.subscribe { [weak self] categoryType, customTopViewBC in
            guard let self else { return }
            self.mainCoordinator?.openMapController(categoryType: categoryType, customTopViewBC: customTopViewBC)
        }.disposed(by: disposeBag)
    }
}

//MARK: - Configure Header's HorizontalCollectionView Cell Size / Padding
extension MainController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = viewModel.calculateCellSize(mainView, collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath)
        
        return cellSize
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let padding = viewModel.addPaddingToHorizontalCells(collectionView, layout: collectionViewLayout, insetForSectionAt: section)
        
        return padding
    }
    
    
}

