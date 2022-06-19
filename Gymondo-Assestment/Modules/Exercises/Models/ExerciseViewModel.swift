//
//  ExerciseViewModel.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/21/1401 AP.
//

import UIKit.UIImage
import Combine

class ExerciseViewModel: Hashable, ObservableObject {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: ExerciseViewModel, rhs: ExerciseViewModel) -> Bool {
        return rhs.id == lhs.id
    }
    
    let id: Int
    var name: String
    private var cancellable: AnyCancellable?
    @Published var image: UIImage = UIImage(named: "placeholder")!
    
    init(name: String, id: Int, imageLoader: AnyPublisher<UIImage, Never>) {
        self.name = name
        self.id = id
        cancellable = imageLoader.sink(receiveValue: { image in
            self.image = image
        })
    }
}
