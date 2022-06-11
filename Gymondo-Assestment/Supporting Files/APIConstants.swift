//
//  APIConstants.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/21/1401 AP.
//

import Foundation

struct APIConstants {
    static private let apiUrl = "https://wger.de/api/v2/"
    static let exercisesUrl = URL(string: apiUrl + "exercises/")!
    static let exerciseImageUrl = URL(string: apiUrl + "exerciseimage/")!
    static let exerciseInfoUrl = URL(string: apiUrl + "exerciseinfo/")!
}
