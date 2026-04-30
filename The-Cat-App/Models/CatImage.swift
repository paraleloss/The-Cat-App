//
//  CatImage.swift
//  The-Cat-App
//
//  Created by Saúl Pérez on 30/04/26.
//

import Foundation

struct CatImage: Codable {
    let id: String
    let url: String
    let width: Int
    let height: Int
    let breeds: [CatBreed]?
    
    enum CodingKeys: String, CodingKey {
        case id, url, width, height, breeds
    }
}
