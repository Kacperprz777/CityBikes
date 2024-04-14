//
//  BikeStationRow.swift
//  CityBikes
//
//  Created by Kacper Przybyła on 14/04/2024.
//

import SwiftUI

struct BikeStationRow: View {
    
    @EnvironmentObject var locationManager: LocationManager
    let station: Station
    var stationName: String
    var emptySlots: Int
    var freeBikes: Int
    var distance: Float = 0.0
    
    init(station: Station) {
        self.station = station
        stationName = station.name
        emptySlots = station.emptySlots
        freeBikes = station.freeBikes
    }
    
    
    var body: some View {
        
        ZStack{
            Image(systemName: "bicycle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.4)
                .padding(10)
                .foregroundStyle(.orange)
            
            VStack {
                Text(stationName)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                Text(String(format: "%.2fkm", locationManager.calculateDistance(from: station.coordinates) ?? ""))
                    .fontWeight(.medium)
                
                HStack(){
                    VStack(alignment: .center, content: {
                        Text("Available bikes")
                            .fontWeight(.medium)
                        Text("\(freeBikes)")
                            .foregroundStyle(freeBikes > 0 ? .green : .red)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        
                    }).padding()
                    
                    VStack(alignment: .center, content: {
                        Text("Available places")
                            .fontWeight(.medium)
                        Text("\(emptySlots)")
                            .foregroundStyle(emptySlots > 0 ? .green : .red)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }).padding()
                }
            }
        }.background(Color(.tertiarySystemFill))
            .clipShape(RoundedRectangle(cornerRadius: 15.0))
            .padding(5)
    }
}


//#Preview {}
