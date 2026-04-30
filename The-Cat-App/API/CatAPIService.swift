//
//  CatAPIService.swift
//  The-Cat-App
//
//  Created by Saúl Pérez on 30/04/26.
//

import Foundation

class CatAPIService {
    static let shared = CatAPIService()
    private let baseURL = "https://api.thecatapi.com/v1"
    // Puedes obtener una API Key gratis en https://thecatapi.com
    private let apiKey = "TU_API_KEY_AQUI" // Deja vacío si no tienes, pero tendrás límites
    
    private init() {}
    
    func fetchBreeds(completion: @escaping ([CatBreed]?, Error?) -> Void) {
        let urlString = "\(baseURL)/breeds"
        
        var request = URLRequest(url: URL(string: urlString)!)
        if !apiKey.isEmpty {
            request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "No data", code: -1))
                return
            }
            
            do {
                let breeds = try JSONDecoder().decode([CatBreed].self, from: data)
                DispatchQueue.main.async {
                    completion(breeds, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }.resume()
    }
    
    func fetchImages(breedId: String, limit: Int, completion: @escaping ([CatImage]?, Error?) -> Void) {
        let urlString = "\(baseURL)/images/search?breed_ids=\(breedId)&limit=\(limit)"
        
        var request = URLRequest(url: URL(string: urlString)!)
        if !apiKey.isEmpty {
            request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "No data", code: -1))
                return
            }
            
            do {
                let images = try JSONDecoder().decode([CatImage].self, from: data)
                DispatchQueue.main.async {
                    completion(images, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }.resume()
    }
}
