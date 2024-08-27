//
//  DetailMapView.swift
//  CityBikes
//
//  Created by Kacper Przybyła on 14/04/2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @StateObject var viewModel: MapViewViewModel
    @State private var mapCameraPosition: MapCameraPosition = .automatic

    var body: some View {
        ZStack{
            
            Map(position: $mapCameraPosition) {
                Annotation(viewModel.stationName, coordinate: viewModel.stationCoordinate) {
                    
                    ZStack {
                        Circle()
                            .foregroundStyle(.orange.opacity(0.5))
                            .frame(width: 70, height: 70)
                        
                        Image(systemName: "bicycle")
                            .symbolEffect(.variableColor)
                            .padding()
                            .foregroundStyle(.white)
                            .background(Color.orange)
                            .clipShape(Circle())
                    }
                }
            }
            .onAppear {
                updateCameraPosition()
            }
            .task {
                await viewModel.fetchStationAddress()
            }
            .onTapGesture {
                viewModel.showDetails.toggle()
            }
            .sheet(isPresented: $viewModel.showDetails, content: {
                LocationDetailsView(showDetails: $viewModel.showDetails,
                                    stationAdress: $viewModel.stationAddress,
                                    requestForLookAroundPreview: createLookAroundSceneRequest(),
                                    stationName: viewModel.stationName
                )
                .presentationDetents([.height(290)])
                .presentationBackgroundInteraction(.enabled(upThrough: .height(290)))
                .presentationCornerRadius(12)
            })
            
        }
    }
    
    private func updateCameraPosition() {
        let regionData = viewModel.stationRegionCoordinates
        let region = MKCoordinateRegion(center: regionData.center, latitudinalMeters: regionData.latitudinalMeters, longitudinalMeters: regionData.longitudinalMeters)
        mapCameraPosition = .region(region)
    }
    
    private func createLookAroundSceneRequest() -> MKLookAroundSceneRequest {
        // Utworzenie MKLookAroundSceneRequest w warstwie UI
        let coordinate = viewModel.stationCoordinate
        return MKLookAroundSceneRequest(coordinate: coordinate)
    }
}


#Preview {
    MapView(viewModel: MapViewViewModel(station: Station(emptySlots: 0, freeBikes: 5, id: "testID", latitude: 52.219916, longitude: 21.011682, name: "Plac Politechniki")))
}
