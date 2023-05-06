//
//  FloatingController.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 5.05.2023.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class FloatingController: UIViewController {
    
    //MARK: - References
    let viewModel: FloatingViewModel?
    private let floatingView = FloatingView()
    
    //MARK: - Dispose Bag
    private let disposeBag = DisposeBag()
    
    //MARK: - Variables
    let categoryType: NetworkConstants?
    
    //MARK: - Life Cycle Methods
    init(categoryType: NetworkConstants, citySlug: String, countySlug: String) {
        self.viewModel = FloatingViewModel(categoryType: categoryType, citySlug: citySlug, countySlug: countySlug)
        self.categoryType = categoryType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle Methods
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    //MARK: - Configure ViewController
    private func configureViewController() {
        configureTableView()
    }
    
    
}

//MARK: - Configure TableView
extension FloatingController {
    private func configureTableView() {
        guard let viewModel, let categoryType else { return }
        // Bind data
        
    }
    
    
}
