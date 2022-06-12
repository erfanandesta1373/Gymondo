//
//  Exercises+Resource.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/21/1401 AP.
//

import Foundation

class ExercisesResource {
    
    func exercises() -> Resource<Exercises> {
        return Resource<Exercises>(url: APIConstants.exercisesUrl)
    }
    func exerciseImage(with id: Int) -> Resource<ExerciseImage> {
        let url = APIConstants.exerciseImageUrl.appendingPathComponent("\(id)")
        return Resource<ExerciseImage>(url: url)
    }
}
