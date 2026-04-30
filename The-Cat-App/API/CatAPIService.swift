//
//  CatAPIService.swift
//  The-Cat-App
//
//  Created by Saúl Pérez on 30/04/26.
//

import Foundation

import Foundation

class CatAPIService {
    static let shared = CatAPIService()
    private let baseURL = "https://api.thecatapi.com/v1"
    
    // ¡¡Cambia esto por tu propia API Key!!
    private let apiKey = "live_tu_api_key_aqui"   // ← Pon la tuya aquí
    
    private init() {}
    
    // Obtener todas las razas
    func fetchBreeds() async throws -> [Breed] {
        let url = URL(string: "\(baseURL)/breeds")!
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode([Breed].self, from: data)
    }
    
    // Buscar imágenes por raza y límite
    func fetchImages(breedId: String, limit: Int) async throws -> [CatImage] {
        var components = URLComponents(string: "\(baseURL)/images/search")!
        components.queryItems = [
            URLQueryItem(name: "breed_ids", value: breedId),
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "has_breeds", value: "1")
        ]
        
        guard let url = components.url else { throw URLError(.badURL) }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode([CatImage].self, from: data)
    }
}
