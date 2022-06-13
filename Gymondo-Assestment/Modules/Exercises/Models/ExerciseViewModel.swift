//
//  ExerciseViewModel.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/21/1401 AP.
//

import UIKit.UIImage
import Combine

struct ExerciseViewModel {
    let id: Int
    let name: String
    let image: AnyPublisher<UIImage, Never>
    
    
    init(name: String, id: Int, imageLoader: (Int) -> AnyPublisher<UIImage, Never>) {
        self.name = name
        self.id = id
        self.image = imageLoader(id)
    }
}
