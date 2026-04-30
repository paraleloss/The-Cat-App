//
//  CatImage.swift
//  The-Cat-App
//
//  Created by Saúl Pérez on 30/04/26.
//

struct CatImage: Decodable {
    let id: String
    let url: String
    let width: Int?
    let height: Int?
    let breeds: [Breed]?
}
