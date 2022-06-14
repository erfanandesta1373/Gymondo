//
//  ExerciseInfoTests.swift
//  Gymondo-AssestmentTests
//
//  Created by Erfan Andesta on 3/24/1401 AP.
//

import XCTest
import Combine
@testable import Gymondo_Assestment

class ExerciseInfoTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    func testGettingExerciseInfo() {
        let id = 174
        let viewModel = ExerciseInfoViewModelTests(id: id)
        let vc = ExerciseInfoTableViewController(viewModel: viewModel, id: id)
        
        vc.bind(to: viewModel)
        
        let expectation = self.expectation(description: "ExerciseInfo")
        
        let _ = XCTWaiter.wait(for: [expectation], timeout: 10)
        
        XCTAssertNotNil(vc.exercise)
        
    }
    
    func testGettingExerciseInfoPublisher() throws {
        let id = 174
        let viewModel = ExerciseInfoViewModelTests(id: id)
        let result = try awaitPublisher(viewModel.getExerciseInfo(with: id))
        var exerciseInfo: ExerciseInfo?
        switch result {
        case .success(let exs):
            exerciseInfo = exs
        case .failure(let er):
            XCTFail(er.localizedDescription)
        }
        
        XCTAssertNotNil(exerciseInfo)
    }
    
    func testGettingExerciseInfoImagesPublisher() throws {
        let id = 174
        let viewModel = ExerciseInfoViewModelTests(id: id)
        let plImage = try awaitPublisher(viewModel.getExerciseImage(with: "https://something.com.png"))
        let placeholder = UIImage(named: "placeholder")
        
        // placeholder check if there is no image
        XCTAssertEqual(plImage, placeholder)
        
        // actual image check
        let image = try awaitPublisher(viewModel.getExerciseImage(with: "https://wger.de/media/exercise-images/192/Bench-press-1.png"))
        XCTAssertNotEqual(image, placeholder)
    }
}
