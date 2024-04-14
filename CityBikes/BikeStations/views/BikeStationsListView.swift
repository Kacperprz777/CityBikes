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

//#Preview {
//}
