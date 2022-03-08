//
//  Restaurant.swift
//  FlorencioBottleRocket
//
//  Created by Florencio Gallegos on 3/6/22.
//

import Foundation

struct RestaurantResponse: Codable {
    let restaurants: [Restaurant]
}

struct Restaurant: Codable {
    let name: String?
    let backgroundImageURL: String?
    let category: String?
    let contact: Contact?
    let location: Location?
}
