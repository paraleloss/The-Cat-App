//
//  CatBreed.swift
//  The-Cat-App
//
//  Created by Saúl Pérez on 30/04/26.
//

import Foundation

struct Breed: Decodable, Hashable {
    let id: String
    let name: String
    let description: String?
    let origin: String?
    let temperament: String?
    
    // to show on table view
    var displayName: String { name }
}

struct BreedResponse: Decodable {
    let breeds: [Breed]
}
