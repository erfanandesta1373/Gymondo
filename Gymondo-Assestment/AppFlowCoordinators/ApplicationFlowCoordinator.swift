//
//  ApplicationFlowCoordinator.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/21/1401 AP.
//

import UIKit

protocol ApplicationFlowCoordinatorDependencyProvider: ExercisesFlowCoordinatorDependencyProvider {}
class ApplicationFlowCoordianator: NSObject, FlowCoordinator {
    
    typealias DependencyProvider = ApplicationFlowCoordinatorDependencyProvider
    
    private let window: UIWindow
    private let dependencyProvider: DependencyProvider
    var childCoordinators = [FlowCoordinator]()

    init(window: UIWindow, dependencyProvider: DependencyProvider) {
        self.window = window
        self.dependencyProvider = dependencyProvider
    }
    
    func start() {
        let exercisesFlowCoordinator = ExercisesFlowCoordinator(window: window, dependencyProvider: dependencyProvider)
        childCoordinators = [exercisesFlowCoordinator]
        exercisesFlowCoordinator.start()
    }
}



