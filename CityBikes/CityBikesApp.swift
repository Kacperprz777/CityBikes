//
//  CityBikesApp.swift
//  CityBikes
//
//  Created by Kacper Przybyła on 04/04/2024.
//

import SwiftUI

@main
struct CityBikesApp: App {
    
    @StateObject var locationManager = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            BikeStationsScreen()
            .environmentObject(locationManager)        }
    }
}
