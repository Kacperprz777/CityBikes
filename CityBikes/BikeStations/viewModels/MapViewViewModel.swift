//
//  MapViewViewModel.swift
//  CityBikes
//
//  Created by Kacper Przybyła on 14/04/2024.
//

import Foundation
import _MapKit_SwiftUI

@MainActor
final class MapViewViewModel: ObservableObject {
    
    @Published var mapCameraPosition: MapCameraPosition = .automatic
    @Published var showDetails: Bool = true
    @Published var stationAdress: String?
    
    
    let station: Station
    
    var stationName: String {
        station.name
    }
    
    var stationRegion: MKCoordinateRegion {
        .init(center: stationCoordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
    }
    
    
    var stationCoordinate: CLLocationCoordinate2D  {
        CLLocationCoordinate2D(latitude: station.latitude, longitude: station.longitude)
    }
    init(station: Station) {
        self.station = station
        updateMapCameraPosition()
    }
    
    func updateMapCameraPosition() {
        mapCameraPosition = .region(stationRegion)
    }
    
    func getRequestForLookAroundPreview() -> MKLookAroundSceneRequest {
        MKLookAroundSceneRequest(coordinate: stationCoordinate)
    }
    
    func fetchStationAddress() async {
        
        do {
            let address = try await getAddressDescription(for: station.coordinates)
            stationAdress = address
        } catch {
            print("Error fetching address:", error)
        }
    }
    
    private func getAddressDescription(for location: CLLocation) async throws -> String? {
        do {
            let placemarks = try await CLGeocoder().reverseGeocodeLocation(location)
            if let place = placemarks.first {
                let addressComponents = [
                    place.thoroughfare,
                    place.subThoroughfare,
                    place.locality
                ].compactMap { $0 }
                let description = addressComponents.joined(separator: ", ")
                return description.isEmpty ? nil : description
            } else {
                throw GeocodingError.noPlacemarkFound
            }
        } catch {
            throw GeocodingError.geocodingFailed(error.localizedDescription)
        }
    }
    
    enum GeocodingError: Error {
        case noPlacemarkFound
        case geocodingFailed(String)
    }
    
}
