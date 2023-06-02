//
//  SelectionPopUpCoordinator.swift
//  SaglikYerleri
//
//  Created by Ekrem Alkan on 2.06.2023.
//

import UIKit

final class SelectionPopUpCoordinator: Coordinator {
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func startCoordinator() {
        let selectionPopUpViewModel = SelectionPopUpViewModel()
        let selectionPopUpController = SelectionPopUpController(viewModel: selectionPopUpViewModel)
        selectionPopUpController.selectionPopUpCoordinator = self
        navigationController.present(selectionPopUpController, animated: false)
    }
    
    func mapClosed() {
        parentCoordinator?.childCoordinatorDidFinish(self)
    }
    
    func openMap(categoryType: NetworkConstants, cellType: CellType, customTopViewBC: UIColor) {
        let childCoordinator = MapCoordinator(navigationController: navigationController)
        childCoordinator.parentCoordinator = parentCoordinator
        childCoordinators.append(childCoordinator)
        childCoordinator.startCoordinator(categoryType: categoryType, cellType: cellType, customTopViewBC: customTopViewBC)
    }
    
    
    
}
