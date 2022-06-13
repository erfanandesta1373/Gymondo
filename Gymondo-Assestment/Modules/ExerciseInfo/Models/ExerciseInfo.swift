//
//  ExerciseInfo.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/22/1401 AP.
//

import Foundation

struct ExerciseInfo: Decodable {
    let id: Int
    let name: String
    private let imageObjects: [ImageObject]
    let variations: [Int]
    
    var images: [String] {
        return imageObjects.map { $0.image }
    }
    
    struct ImageObject: Decodable {
        let image: String
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, variations
        case imageObjects = "images"
    }
}
