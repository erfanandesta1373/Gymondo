//
//  ExerciseInfoFlowCoordinator.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/23/1401 AP.
//

import UIKit

class ExerciseInfoFlowCoordinator: NSObject, FlowCoordinator {
    
    typealias DependencyProvider = ExerciseInfloFlowCoordinatorDependencyProvider
    
    private let dependencyProvider: DependencyProvider
    private var navigationController: UINavigationController
    var childCoordinators = [FlowCoordinator]()
    private let id: Int
    
    init(navigationController: UINavigationController, dependencyProvider: DependencyProvider, id: Int) {
        self.navigationController = navigationController
        self.dependencyProvider = dependencyProvider
        self.id = id
    }
    
    func start() {
        let exerciseInfoVC = dependencyProvider.exerciseInfo(with: id, withNavigator: self)
        navigationController.pushViewController(exerciseInfoVC, animated: true)
    }
    func showExerciseDetail(with id: Int) {
        let exerciseInfoCoordinator = dependencyProvider.exerciseInfoCoordinator(with: id, navigationController: navigationController)
        exerciseInfoCoordinator.start()
        childCoordinators.append(exerciseInfoCoordinator)
    }
}
extension ExerciseInfoFlowCoordinator: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        if let infoVC = fromViewController as? ExerciseInfoTableViewController {
            childDidFinish(infoVC.viewModel.navigator)
        }
    }
}
