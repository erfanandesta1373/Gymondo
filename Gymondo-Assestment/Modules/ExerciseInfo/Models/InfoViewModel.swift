//
//  InfoViewModel.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/22/1401 AP.
//

import UIKit.UIImage
import Combine

struct InfoViewModel {
    let id: Int
    let name: String
    let images: [AnyPublisher<UIImage, Never>]
    let variations: [Int]
}
