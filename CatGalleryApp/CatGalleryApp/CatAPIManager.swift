//
//  CatAPIManager.swift
//  CatGalleryApp
//
//  Created by Marmik Nalinkumar Patel on 2025-04-19.
//

import Foundation

class CatAPIManager {
    static let shared = CatAPIManager()
    
    func fetchRandomCatImage(completion: @escaping (String?) -> Void) {
        let url = URL(string: "https://api.thecatapi.com/v1/images/search")!
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { completion(nil); return }
            if let catImages = try? JSONDecoder().decode([CatImage].self, from: data),
               let imageUrl = catImages.first?.url {
                completion(imageUrl)
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    func fetchCatFact(completion: @escaping (String?) -> Void) {
        let url = URL(string: "https://catfact.ninja/fact")!
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { completion(nil); return }
            if let fact = try? JSONDecoder().decode(CatFact.self, from: data) {
                completion(fact.fact)
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    func fetchCatImages(count: Int, completion: @escaping ([String]) -> Void) {
        let url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=\(count)")!
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { completion([]); return }
            if let catImages = try? JSONDecoder().decode([CatImage].self, from: data) {
                completion(catImages.map { $0.url })
            } else {
                completion([])
            }
        }.resume()
    }
}
