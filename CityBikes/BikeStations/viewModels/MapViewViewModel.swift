//
//  MapViewViewModel.swift
//  CityBikes
//
//  Created by Kacper Przybyła on 14/04/2024.
//

import Foundation
import CoreLocation

@MainActor
final class MapViewViewModel: ObservableObject {
    
    @Published var showDetails: Bool = true
    @Published var stationAddress: String?
    
    
    private let station: Station
    private let geocoder: CLGeocoder
    
    var stationName: String {
        station.name
    }
    
    var stationRegionCoordinates: (center: CLLocationCoordinate2D, latitudinalMeters: CLLocationDistance, longitudinalMeters: CLLocationDistance ) {
        (center: stationCoordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
    }
    
    
    var stationCoordinate: CLLocationCoordinate2D  {
        CLLocationCoordinate2D(latitude: station.latitude, longitude: station.longitude)
    }
    init(station: Station, geocoder: CLGeocoder = CLGeocoder()) {
        self.station = station
        self.geocoder = geocoder
    }
    
    
    func fetchStationAddress() async {
        
        do {
            let address = try await getAddressDescription(for: stationCoordinate)
            stationAddress = address
        } catch {
            print("Error fetching address:", error)
        }
    }
    
    private func getAddressDescription(for coordinate: CLLocationCoordinate2D) async throws -> String? {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(location)
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
