//
//  ExerciseInfoViewModel.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/22/1401 AP.
//

import Foundation
import Combine
import UIKit


struct ExerciseInfoViewModelInput {
    let appear: CurrentValueSubject<Int, Never>
    let selection: PassthroughSubject<Int, Never>
}

enum ExerciseInfoState {
    case success(InfoViewModel)
    case failure(Error)
}

typealias ExerciseInfoViewModelOuput = AnyPublisher<ExerciseInfoState, Never>

class ExerciseInfoViewModel {
    
    weak var navigator: ExerciseInfoFlowCoordinator?
    private let networkService: NetworkServiceType
    private let imageLoaderService: ImageLoaderServiceType
    private var cancellables = [AnyCancellable]()
    
    init(navigator: ExerciseInfoFlowCoordinator, networkService: NetworkServiceType, imageLoaderService: ImageLoaderServiceType) {
        self.networkService = networkService
        self.imageLoaderService = imageLoaderService
        self.navigator = navigator
    }
    
    func transform(input: ExerciseInfoViewModelInput) -> ExerciseInfoViewModelOuput {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        input.selection
            .sink { id in
                self.navigator?.showExerciseDetail(with: id)
            }.store(in: &cancellables)
        
        let exerciseInfo = input.appear
            .flatMap { id in
                self.getExerciseInfo(with: id)
            }
            .map { [unowned self] result -> ExerciseInfoState in
                switch result {
                case .success(let exerciseInfo): return .success(self.viewModels(from: exerciseInfo))
                case .failure(let error): return .failure(error)
                }
            }.eraseToAnyPublisher()
        
        return exerciseInfo
    }
    
    private func viewModels(from exerciseInfo: ExerciseInfo) -> InfoViewModel {
        return InfoViewModel(id: exerciseInfo.id, name: exerciseInfo.name, images: exerciseInfo.images.map({ getExerciseImage(with: $0) }), variations: exerciseInfo.variations)
    }
    private func getExerciseInfo(with id: Int) -> AnyPublisher<Result<ExerciseInfo, Error>, Never> {
        return networkService.load(ExerciseInfoResource().exerciseInfo(with: id))
            .map { .success($0) }
            .catch { error -> AnyPublisher<Result<ExerciseInfo, Error>, Never> in
                    .just(.failure(error))
            }
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .share()
            .eraseToAnyPublisher()
    }
    private func getExerciseImage(with url: String) -> AnyPublisher<UIImage, Never> {
        let placeholder = UIImage(named: "placeholder")!
        return Deferred {
             return Just(url)
        }
            .flatMap { [unowned self] url -> AnyPublisher<UIImage?, Never> in
                guard let url = URL(string: url) else { return .just(placeholder) }
                return self.imageLoaderService.loadImage(from: url)
            }
            .compactMap({ $0 ?? placeholder })
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
}
