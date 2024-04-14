//
//  CityBikesResponse.swift
//  CityBikes
//
//  Created by Kacper Przybyła on 14/04/2024.
//

import Foundation


struct CityBikesResponse: Decodable {
    let network: Network
}

struct Network: Decodable {
    let stations: [Station]
}
