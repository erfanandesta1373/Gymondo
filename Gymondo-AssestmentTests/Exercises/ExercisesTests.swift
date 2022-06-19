//
//  ExercisesTests.swift
//  Gymondo-AssestmentTests
//
//  Created by Erfan Andesta on 3/24/1401 AP.
//

import XCTest
import Combine
@testable import Gymondo_Assestment

class ExercisesTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    func testGettingExercises() {
        let viewModel = ExercisesViewModelTests()
        let vc = ExerciseListView(viewModel: viewModel)
        
        
        let expectation = self.expectation(description: "Exercises")
        
        let _ = XCTWaiter.wait(for: [expectation], timeout: 10)
        
        switch viewModel.state {
        case .idle, .loading:
            XCTFail("Incorrect state")
        case .success(_):
            break
        case .noResults:
            XCTFail("Empty list")
        case .failure(let error):
            XCTFail("Failed with error: \(error)")
        }
        
    }
    
    func testGettingExercisesPublisher() throws {
        let viewModel = ExercisesViewModelTests()
        let result = try awaitPublisher(viewModel.getExercises())
        var exercises: [Exercise] = []
        switch result {
        case .success(let exs):
            exercises = exs
        case .failure(let er):
            XCTFail(er.localizedDescription)
        }
        
        XCTAssertFalse(exercises.isEmpty)
    }
    
    func testGettingExerciseImagesPublisher() throws {
        let viewModel = ExercisesViewModelTests()
        let plImage = try awaitPublisher(viewModel.getExerciseImage(with: -1))
        let placeholder = UIImage(named: "placeholder")
        
        // placeholder check if there is no image
        XCTAssertEqual(plImage, placeholder)
        
        // actual image check
        let image = try awaitPublisher(viewModel.getExerciseImage(with: 174))
        XCTAssertNotEqual(image, placeholder)
    }
}
