//
//  ApplicationComponentFactory.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/21/1401 AP.
//

import Foundation
import UIKit

class ApplicationComponentsFactory: ApplicationFlowCoordinatorDependencyProvider {
    func exercises() -> UINavigationController {
        let viewModel = ExercisesViewModel()
        let vc = ExercisesTableViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: vc)
    }
    
    func exerciseInfo(with id: Int) -> UIViewController {
        return UIViewController()
    }
}
