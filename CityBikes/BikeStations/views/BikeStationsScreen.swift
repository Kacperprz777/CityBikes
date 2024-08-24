//
//  BikeStationsScreen.swift
//  CityBikes
//
//  Created by Kacper Przybyła on 14/04/2024.
//

import SwiftUI

struct BikeStationsScreen: View {
    
    @EnvironmentObject var locationManager: LocationManager
    @StateObject var viewModel: BikeStationsViewModel = BikeStationsViewModel()
    
    var body: some View {
        NavigationStack {
            if locationManager.locationIsDisabled {
                RequestLocationView()
            } else {
                BikeStationsListView(stations:  $viewModel.allStations)
                    .navigationTitle("City bikes")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    BikeStationsScreen().environmentObject(LocationManager())
}
