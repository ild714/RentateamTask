//
//  NetworkService.swift
//  RentateamApp
//
//  Created by Ildar on 2/16/21.
//

import Foundation

protocol NetworkServiceProtocol {
    func getPhotos(completion: @escaping((Result<[Photo]?,Error>) -> Void))
}

class NetworkService: NetworkServiceProtocol {
    func getPhotos(completion: @escaping ((Result<[Photo]?, Error>) -> Void)) {
        let urlString = "https://jsonplaceholder.typicode.com/photos"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                do {
                    let photos = try JSONDecoder().decode([Photo].self, from: data)
                    completion(.success(photos))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
