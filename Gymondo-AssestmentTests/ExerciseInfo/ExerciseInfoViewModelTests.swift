//
//  ExerciseInfoViewModelTests.swift
//  Gymondo-AssestmentTests
//
//  Created by Erfan Andesta on 3/24/1401 AP.
//

import UIKit
@testable import Gymondo_Assestment

class ExerciseInfoViewModelTests: ExerciseInfoViewModel {
    
    init(id: Int) {
        super.init(navigator: .init(navigationController: .init(), dependencyProvider: ExerciseInfoComponentFactory(), id: id), networkService: NetworkService(), imageLoaderService: ImageLoaderService())
    }
}
