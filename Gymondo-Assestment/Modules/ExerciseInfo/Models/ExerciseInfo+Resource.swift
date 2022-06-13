//
//  ExerciseInfo+Resource.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/22/1401 AP.
//

import Foundation

class ExerciseInfoResource {
    
    func exerciseInfo(with id: Int) -> Resource<ExerciseInfo> {
        let url = APIConstants.exerciseInfoUrl.appendingPathComponent("\(id)")
        return Resource<ExerciseInfo>(url: url)
    }
}
