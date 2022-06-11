//
//  ExercisesFlowCoordinatorDependencyProvider.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/21/1401 AP.
//

import UIKit

protocol ExercisesFlowCoordinatorDependencyProvider {
    func exercises() -> UINavigationController
    func exerciseInfo(with id: Int) -> UIViewController
}
