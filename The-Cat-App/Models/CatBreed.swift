//
//  CatBreed.swift
//  The-Cat-App
//
//  Created by Saúl Pérez on 30/04/26.
//

import Foundation

struct CatBreed: Codable {
    let id: String
    let name: String
    let temperament: String?
    let origin: String?
    let lifeSpan: String?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, temperament, origin
        case lifeSpan = "life_span"
        case description
    }
}
