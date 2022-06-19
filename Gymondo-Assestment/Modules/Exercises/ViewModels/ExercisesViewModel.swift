//
//  ExercisesViewModel.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/21/1401 AP.
//

import Foundation
import Combine
import UIKit


struct ExercisesViewModelInput {
    let appear: PassthroughSubject<Void, Never>
    let selection: PassthroughSubject<Int, Never>
}

enum ExerciseState {
    case idle
    case loading
    case success([ExerciseViewModel])
    case noResults
    case failure(Error)
}

typealias ExerciseViewModelOuput = AnyPublisher<ExerciseState, Never>


protocol ExercisesViewModelProtocol {
    func transform(input: ExercisesViewModelInput)
    func viewModels(from exercises: [Exercise]) -> [ExerciseViewModel]
    func getExercises() -> AnyPublisher<Result<[Exercise], Error>, Never>
    func getExerciseImage(with id: Int) -> AnyPublisher<UIImage, Never>
}

class ExercisesViewModel: ExercisesViewModelProtocol, ObservableObject {
    
    private weak var navigator: ExercisesFlowCoordinator?
    private let networkService: NetworkServiceType
    private let imageLoaderService: ImageLoaderServiceType
    private var cancellables = [AnyCancellable]()
    private var exerciseObjects = [Int: ExerciseImage?]()

    @Published var state: ExerciseState = .idle
    @Published var images: [UIImage] = []
    
    init(navigator: ExercisesFlowCoordinator, networkService: NetworkServiceType, imageLoaderService: ImageLoaderServiceType) {
        self.navigator = navigator
        self.networkService = networkService
        self.imageLoaderService = imageLoaderService
    }
    
    func transform(input: ExercisesViewModelInput) {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        input.selection
            .sink { [weak navigator] id in
                navigator?.showExerciseDetail(with: id)
            }.store(in: &cancellables)
        
        input.appear
            .flatMap { _ -> AnyPublisher<Result<[Exercise], Error>, Never> in
                self.state = .loading
                return self.getExercises()
            }
            .map { [weak self] result -> ExerciseState in
                switch result {
                case .success(let exercises) where exercises.isEmpty: return .noResults
                case .success(let exercises): return .success(self?.viewModels(from: exercises) ?? [])
                case .failure(let error): return .failure(error)
                }
            }
            .assign(to: &$state)
    }
    
    func viewModels(from exercises: [Exercise]) -> [ExerciseViewModel] {
        return exercises.map { exercise in
            ExerciseViewModel(name: exercise.name, id: exercise.id, imageLoader: self.getExerciseImage(with: exercise.id))
        }
    }
    func getExercises() -> AnyPublisher<Result<[Exercise], Error>, Never> {
        return networkService.load(ExercisesResource().exercises())
            .map { .success($0.results) }
            .catch { error -> AnyPublisher<Result<[Exercise], Error>, Never> in
                    .just(.failure(error))
            }
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
    func getExerciseImage(with id: Int) -> AnyPublisher<UIImage, Never> {
        let placeholder = UIImage(named: "placeholder")!
        return Deferred {
             return Just(id)
        }
            .flatMap { [unowned self] id -> AnyPublisher<ExerciseImage?, Error> in
                if let obj = exerciseObjects[id] {
                    return .just(obj ?? nil)
                }
                return networkService.load(ExercisesResource().exerciseImage(with: id))
            }.handleEvents(receiveOutput: { [unowned self] object in
                self.exerciseObjects[id] = object
            })
            .flatMap { [unowned self] url -> AnyPublisher<UIImage?, Never> in
                guard let url = URL(string: url?.image ?? "") else { return .just(placeholder) }
                return self.imageLoaderService.loadImage(from: url)
            }
            .compactMap({ $0 ?? placeholder })
            .catch({ error -> AnyPublisher<UIImage, Never> in
                self.exerciseObjects[id] = ExerciseImage(id: -1, image: nil)
                return .just(placeholder)
            })
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
}
