//
//  ExerciseListView.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/28/1401 AP.
//

import SwiftUI
import Combine

struct ExerciseListView: View {
    
    @ObservedObject var viewModel: ExercisesViewModel
    
    private let appear: PassthroughSubject<Void, Never> = .init()
    private let selection: PassthroughSubject<Int, Never> = .init()
    
    init(viewModel: ExercisesViewModel) {
        self.viewModel = viewModel
        self.viewModel.transform(input: .init(appear: appear, selection: selection))
        appear.send()
    }
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            Color.clear
        case .loading:
            ProgressView()
        case .noResults:
            Text("No results")
        case .success(let exercises):
            List {
                ForEach(exercises, id: \.self) { item in
                    Button {
                        selection.send(item.id)
                    } label: {
                        ExerciseView(model: item)
                    }
                    
                }
            }
        case .failure(let error):
            Text("Error: \(error.localizedDescription)")
        }
    }
}

struct ExerciseListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ExercisesViewModel(navigator: .init(window: UIWindow(), dependencyProvider: ApplicationComponentsFactory()),networkService: NetworkService(), imageLoaderService: ImageLoaderService())
        ExerciseListView(viewModel: viewModel)
    }
}
