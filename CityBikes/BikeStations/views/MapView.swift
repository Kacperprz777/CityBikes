//
//  DetailMapView.swift
//  CityBikes
//
//  Created by Kacper Przybyła on 14/04/2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @StateObject var viewModel: DetailViewViewModel
    
    var body: some View {
        ZStack{
            
            Map(position: $viewModel.mapCameraPosition) {
                Annotation(viewModel.station.name, coordinate: viewModel.stationCoordinate) {
                    
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
            }.task {
                await viewModel.fetchStationAddress()
            }
            .onTapGesture {
                viewModel.showDetails.toggle()
            }
            .sheet(isPresented: $viewModel.showDetails, content: {
                LocationDetailsView(showDetails: $viewModel.showDetails,
                                    stationAdress: $viewModel.stationAdress,
                                    requestForLookAroundPreview: viewModel.getRequestForLookAroundPreview(),
                                    stationName: viewModel.stationName
                )
                .presentationDetents([.height(290)])
                .presentationBackgroundInteraction(.enabled(upThrough: .height(290)))
                .presentationCornerRadius(12)
            })
            
        }
    }
}


//#Preview {
//}
