//
//  NetworkError.swift
//  FlorencioBottleRocket
//
//  Created by Florencio Gallegos on 3/6/22.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case badURL
    case other(Error)
    
    var errorDescription: String? {
    switch self {
    case .badURL:
        return "This is a bad url"
    case .other(let error):
        return error.localizedDescription
    }
    }
}
