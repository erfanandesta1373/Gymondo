//
//  ExercisesViewModelTests.swift
//  Gymondo-AssestmentTests
//
//  Created by Erfan Andesta on 3/24/1401 AP.
//

import UIKit
@testable import Gymondo_Assestment

class ExercisesViewModelTests: ExercisesViewModel {
    
    init() {
        super.init(navigator: .init(window: UIWindow(), dependencyProvider: ApplicationComponentsFactory()), networkService: NetworkService(), imageLoaderService: ImageLoaderService())
    }
}
