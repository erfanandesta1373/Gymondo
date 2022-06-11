//
//  ExercisesFlowCoordinator.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/21/1401 AP.
//

import UIKit

class ExercisesFlowCoordinator: FlowCoordinator {
    
    typealias DependencyProvider = ExercisesFlowCoordinatorDependencyProvider
    
    private let window: UIWindow
    private let dependencyProvider: DependencyProvider
    private var navigationController: UINavigationController?
    private var childCoordinators = [FlowCoordinator]()
    
    init(window: UIWindow, dependencyProvider: DependencyProvider) {
        self.window = window
        self.dependencyProvider = dependencyProvider
    }
    
    func start() {
        let exercisesVC = dependencyProvider.exercises()
        window.rootViewController = exercisesVC
        navigationController = exercisesVC
    }
}
