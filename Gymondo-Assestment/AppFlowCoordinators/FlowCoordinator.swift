//
//  FlowCoordinator.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/21/1401 AP.
//

import Foundation

protocol FlowCoordinator: NSObject {
    var childCoordinators: [FlowCoordinator] { get set }
    func start()
    func childDidFinish(_ child: FlowCoordinator?)
}
extension FlowCoordinator {
    func childDidFinish(_ child: FlowCoordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
