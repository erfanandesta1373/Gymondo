//
//  Exercises.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/21/1401 AP.
//

import Foundation

struct Exercises: Decodable {
    let results: [Exercise]
}
struct Exercise: Decodable {
    let id: Int
    let name: String
}
struct ExerciseImage: Decodable {
    let id: Int
    let image: String?
}

