//
//  LocationDetailsView.swift
//  CityBikes
//
//  Created by Kacper Przybyła on 14/04/2024.
//

import SwiftUI
import MapKit

struct LocationDetailsView: View {
    
    
    @State var lookAroundScene: MKLookAroundScene?
    @Binding  var showDetails: Bool
    @Binding var stationAdress: String?
    
    let requestForLookAroundPreview: MKLookAroundSceneRequest
    let stationName: String
    
    var body: some View {
        
        VStack {
            HStack {
                VStack(alignment: .leading)  {
                    Text(stationName)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(stationAdress ?? "")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                        .lineLimit(2)
                        .padding(.trailing)
                }
                Spacer()
                
                Button {
                    showDetails.toggle()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.gray, Color(.systemGray6))
                }
            }
            
            if let scene = lookAroundScene {
                LookAroundPreview(initialScene: scene)
                    .frame(height: 200)
                    .cornerRadius(12)
                    .padding()
            } else {
                ContentUnavailableView("No preview available", systemImage: "eye.slash")
            }
            
        }.padding()
            .task {
                lookAroundScene = try? await requestForLookAroundPreview.scene
            }
    }
}

//#Preview {
//    LocationDetailsView()
//}
