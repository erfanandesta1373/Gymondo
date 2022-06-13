//
//  ExercisesFlowCoordinatorDependencyProvider.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/21/1401 AP.
//

import UIKit

protocol ExercisesFlowCoordinatorDependencyProvider {
    func exercises(with navigator: ExercisesFlowCoordinator) -> UINavigationController
    func exerciseInfoCoordinator(with id: Int, navigationController: UINavigationController) -> ExerciseInfoFlowCoordinator
}
