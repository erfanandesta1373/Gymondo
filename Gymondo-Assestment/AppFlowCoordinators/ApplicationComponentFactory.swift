//
//  ApplicationComponentFactory.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/21/1401 AP.
//

import Foundation
import UIKit
import SwiftUI

class ApplicationComponentsFactory: ApplicationFlowCoordinatorDependencyProvider {
    func exerciseInfoCoordinator(with id: Int, navigationController: UINavigationController) -> ExerciseInfoFlowCoordinator {
        return ExerciseInfoFlowCoordinator(navigationController: navigationController, dependencyProvider: ExerciseInfoComponentFactory(), id: id)
    }
    
    func exercises(with navigator: ExercisesFlowCoordinator) -> UINavigationController {
        let viewModel = ExercisesViewModel(navigator: navigator, networkService: NetworkService(), imageLoaderService: ImageLoaderService())
        let view = ExerciseListView(viewModel: viewModel)
        let host = UIHostingController(rootView: view)
        host.title = "Exercises"
        let nav = UINavigationController(rootViewController: host)
        nav.navigationBar.prefersLargeTitles = true
        return nav
    }
}
