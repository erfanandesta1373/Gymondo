//
//  ExercisesFlowCoordinator.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/21/1401 AP.
//

import UIKit

class ExercisesFlowCoordinator: NSObject, FlowCoordinator {
    
    typealias DependencyProvider = ExercisesFlowCoordinatorDependencyProvider
    
    private let window: UIWindow
    private let dependencyProvider: DependencyProvider
    private var navigationController: UINavigationController?
    var childCoordinators = [FlowCoordinator]()
    
    init(window: UIWindow, dependencyProvider: DependencyProvider) {
        self.window = window
        self.dependencyProvider = dependencyProvider
    }
    
    func start() {
        let exercisesVC = dependencyProvider.exercises(with: self)
        window.rootViewController = exercisesVC
        navigationController = exercisesVC
        navigationController?.delegate = self
    }
    func showExerciseDetail(with id: Int) {
        let exerciseInfoCoordinator = dependencyProvider.exerciseInfoCoordinator(with: id, navigationController: navigationController ?? UINavigationController())
        exerciseInfoCoordinator.start()
        childCoordinators.append(exerciseInfoCoordinator)
    }

}
extension ExercisesFlowCoordinator: UINavigationControllerDelegate {
    
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
