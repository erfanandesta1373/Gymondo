//
//  ExerciseInfloFlowCoordinatorDependencyProvider.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/23/1401 AP.
//

import UIKit.UIViewController

protocol ExerciseInfloFlowCoordinatorDependencyProvider {
    func exerciseInfo(with id: Int, withNavigator navigator: ExerciseInfoFlowCoordinator) -> UIViewController
    func exerciseInfoCoordinator(with id: Int, navigationController: UINavigationController) -> ExerciseInfoFlowCoordinator
}
class ExerciseInfoComponentFactory: ExerciseInfloFlowCoordinatorDependencyProvider {
    func exerciseInfo(with id: Int, withNavigator navigator: ExerciseInfoFlowCoordinator) -> UIViewController {
        let viewModel = ExerciseInfoViewModel(navigator: navigator, networkService: NetworkService(), imageLoaderService: ImageLoaderService())
        return ExerciseInfoTableViewController(viewModel: viewModel, id: id)
    }
    func exerciseInfoCoordinator(with id: Int, navigationController: UINavigationController) -> ExerciseInfoFlowCoordinator {
        return ExerciseInfoFlowCoordinator(navigationController: navigationController, dependencyProvider: ExerciseInfoComponentFactory(), id: id)
    }
    
    
    
}
