//
//  Location.swift
//  FlorencioBottleRocket
//
//  Created by Florencio Gallegos on 3/6/22.
//

import Foundation

struct Location: Codable {
    let address: String?
    let crossStreet: String?
    let lat, lng: Double
    let postalCode: String?
    let cc: Cc?
    let city: City?
    let state: State
    let country: Country?
    let formattedAddress: [String]
}

enum Cc: String, Codable {
    case us = "US"
}

enum City: String, Codable {
    case addison = "Addison"
    case dallas = "Dallas"
}

enum Country: String, Codable {
    case unitedStates = "United States"
}

enum State: String, Codable {
    case tx = "TX"
}
