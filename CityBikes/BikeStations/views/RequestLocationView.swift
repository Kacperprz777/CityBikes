//
//  RequestLocationView.swift
//  CityBikes
//
//  Created by Kacper Przybyła on 14/04/2024.
//

import SwiftUI
import CoreLocationUI

struct RequestLocationView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack {
            Image(systemName: "bicycle")
                .resizable()
                .frame(width: 245, height: 175)
                .foregroundStyle(.orange)
            Text(
        """
        To find bike stations near you, first, you need to
        share your current location.
        """
            )
            .multilineTextAlignment(.center)
            LocationButton {
                locationManager.requestWhenInUseAuthorization()
            }
            .symbolVariant(.fill)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
        .onAppear {
            locationManager.updateAuthorizationStatus()
        }
    }
}

#Preview {
    RequestLocationView().environmentObject(LocationManager())
}
