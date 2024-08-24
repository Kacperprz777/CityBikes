//
//  BikeStationsListView.swift
//  CityBikes
//
//  Created by Kacper Przybyła on 14/04/2024.
//

import SwiftUI

struct BikeStationsListView: View {
    
    @Binding var stations: [Station]
    
    var body: some View {
        
        List {
            ForEach(stations) { station in
                NavigationLink(destination: MapView(viewModel: MapViewViewModel(station: station))) {
                    BikeStationRow(station: station)
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color(UIColor.systemBackground))
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    @State var sampleStations = [
        Station(emptySlots: 5, freeBikes: 10, id: "1", latitude: 52.219916, longitude: 21.011682, name: "Station 1"),
        Station(emptySlots: 2, freeBikes: 8, id: "2", latitude: 52.229916, longitude: 21.021682, name: "Station 2"),
        Station(emptySlots: 0, freeBikes: 0, id: "3", latitude: 52.239916, longitude: 21.031682, name: "Station 3")
    ]
    
    return BikeStationsListView(stations: $sampleStations).environmentObject(LocationManager())
}
