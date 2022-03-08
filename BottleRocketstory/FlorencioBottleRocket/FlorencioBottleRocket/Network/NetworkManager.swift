//
//  NetworkManager.swift
//  FlorencioBottleRocket
//
//  Created by Florencio Gallegos on 3/6/22.
//

import Foundation

class NetworkManager {
    
    static func getRestaurant(from url: String, completion: @escaping (Result<RestaurantResponse, NetworkError>) -> ()) {
        guard let url = URL(string: url) else {
            completion(.failure(.badURL))
            return }
      
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                completion(.failure(NetworkError.other(error)))
                return
            }
            
            if let data = data {
                do {
                    let restaurants = try JSONDecoder().decode(RestaurantResponse.self, from: data)
                    completion(.success(restaurants))
                } catch let error  {
                    completion(.failure(.other(error)))
                }
            }
        }.resume()
    }

    static func getImageData(_ url: String, completion: @escaping(Data?) -> Void ) {
        guard let url = URL(string: url) else {
            completion(nil)
            return
    }
        URLSession.shared.dataTask(with: url) { data, response , error in
            completion(data)
        }
        .resume()
    }
}
