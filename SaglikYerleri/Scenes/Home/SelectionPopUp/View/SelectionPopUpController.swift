//
//  SelectionPopUpController.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 1.06.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class SelectionPopUpController: UIViewController {
    deinit {
        print("SelectionPopUpController deinit")
    }
    //MARK: - References
    weak var selectionPopUpCoordinator: SelectionPopUpCoordinator?
    private let selectionPopUpView = SelectionPopUpView()
    private let viewModel: SelectionPopUpViewModel
    
    //MARK: - Dispose Bag
    private let disposeBag = DisposeBag()
    
    //MARK: - LastSelectedCellIndexPath
    var lastSelectedCellIndexPath: IndexPath?
    var selectedCategory: MainHorizontalCollectionData?
    
    //MARK: - Life Cycle Methods
    init(viewModel: SelectionPopUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showPopUpView()
    }
    
    private func configureViewController() {
        setupView()
        appearanceWhenViewDidLoad()
        configureCollectionView()
        tapGestureCallback()
        buttonCallbacks()
    }
    
    private func tapGestureCallback() {
        selectionPopUpView.emptyViewTapGesture.rx.event.subscribe { [weak self] event  in
            guard let self else { return }
            hidePopUpView()
        }.disposed(by: disposeBag)
        
    }
    
    private func buttonCallbacks() {
        selectionPopUpView.disMissButton.rx.tap.subscribe { [weak self] _   in
            guard let self else { return }
            selectionPopUpView.animateContentViewAndDismissParent { [weak self] in
                guard let self else { return }
                hidePopUpView()
            }
        }.disposed(by: disposeBag)
        
        
        selectionPopUpView.openMapButton.rx.tap.subscribe { [weak self] _ in
            guard let self, let selectedCategory else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                hidePopUpView()
                selectionPopUpCoordinator?.openMap(categoryType: selectedCategory.selectedCategoryType, cellType: selectedCategory.cellTypeAccorindToCategory, customTopViewBC: .init(hex: selectedCategory.tintAndBackgroundColor))
            }

        }.disposed(by: disposeBag)
    }
}

//MARK: - Configure Collection View
extension SelectionPopUpController: UICollectionViewDelegateFlowLayout {
    private func configureCollectionView() {
        // bind data
        viewModel.collectionViewData.bind(to: selectionPopUpView.optionsCollectionView.rx.items(cellIdentifier: SelectionPopUpCell.identifier, cellType: SelectionPopUpCell.self)) { index, data, cell in
            cell.configure(with: data)
            
        }.disposed(by: disposeBag)
        
        
        selectionPopUpView.optionsCollectionView.rx.modelSelected(MainHorizontalCollectionData.self).subscribe(onNext: { [weak self] selectedCategory in
            guard let self else { return }
            selectionPopUpView.showButtons(buttonIsHidden: false)
            self.selectedCategory = selectedCategory
        }).disposed(by: disposeBag)
        
        // set delegate for cell size
        selectionPopUpView.optionsCollectionView.rx.setDelegate(self).disposed(by: disposeBag
        )
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 130)
    }
}

//MARK: - SelectionPopUpView Hide/Show
extension SelectionPopUpController {
    private func appearanceWhenViewDidLoad() {
        view.backgroundColor = .clear
        selectionPopUpView.emptyView.backgroundColor = .black.withAlphaComponent(0.6)
        selectionPopUpView.alpha = 0
        selectionPopUpView.contentView.alpha = 0
    }
    
    private func showPopUpView() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            selectionPopUpView.alpha = 1
            selectionPopUpView.contentView.alpha = 1
        }
    }
    
    private func hidePopUpView() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) { [weak self] in
            guard let self else { return }
            selectionPopUpView.alpha = 0
            selectionPopUpView.contentView.alpha = 0
        } completion: { [weak self] _ in
            guard let self else { return }
            dismiss(animated: false, completion: { [weak self] in
                guard let self else { return }
                selectionPopUpCoordinator?.mapClosed()
                removeFromParent()
            })
            
        }
        
    }
}

//MARK: - View AddSubview / SetupConstraints
extension SelectionPopUpController {
    private func setupView() {
        view.addSubview(selectionPopUpView)
        
        selectionPopUpView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    
}
