//
//  ContentView.swift
//  CityBikes
//
//  Created by Kacper Przybyła on 04/04/2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    
    var body: some View {

        BikeStationsScreen()
            .environmentObject(locationManager)
    }
}

#Preview {
    ContentView()
}
