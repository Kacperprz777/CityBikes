//
//  Station.swift
//  CityBikes
//
//  Created by Kacper Przybyła on 14/04/2024.
//

import CoreLocation

struct Station: Decodable, Identifiable, Hashable {
    let emptySlots: Int
    let freeBikes: Int
    let id: String
    let latitude, longitude: Double
    let name: String
    var distance: Float = 0.0
    var coordinates: CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    enum CodingKeys: String, CodingKey {
        case emptySlots = "empty_slots"
        case freeBikes = "free_bikes"
        case id, latitude, longitude, name
    }
}

