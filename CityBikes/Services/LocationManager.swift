//
//  LocationManager.swift
//  CityBikes
//
//  Created by Kacper Przybyła on 14/04/2024.
//

import CoreLocation
import Foundation

final class LocationManager: NSObject, ObservableObject {
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var lastSeenLocation: CLLocation?
    
    private let cllLocationManager: CLLocationManager
    
    init(authorizationStatus: CLAuthorizationStatus = .notDetermined) {
        self.authorizationStatus = authorizationStatus
        self.cllLocationManager = CLLocationManager()
        super.init()
        cllLocationManager.delegate = self
        cllLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.authorizationStatus = cllLocationManager.authorizationStatus
        cllLocationManager.startUpdatingLocation()
    }
    
    
    func updateAuthorizationStatus() {
        authorizationStatus = cllLocationManager.authorizationStatus
    }
    
    func requestWhenInUseAuthorization() {
        cllLocationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        cllLocationManager.startUpdatingLocation()
    }
    
    
    func calculateDistance(from location: CLLocation) -> Float? {
        
        if let lastSeenLocation = lastSeenLocation {
            let distance = lastSeenLocation.distance(from: location)
            let distanceInKilometers = Float(distance)/1000
            return distanceInKilometers
        } else {
            return nil
        }
    }
    
}


// MARK: - Location status
extension LocationManager {
  var locationIsDisabled: Bool {
    authorizationStatus == .denied ||
      authorizationStatus == .notDetermined ||
      authorizationStatus == .restricted
  }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    updateAuthorizationStatus()
  }

  func locationManager(
    _ manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]
  ) {
    guard let location = locations.first else { return }
    lastSeenLocation = location
  }

  func locationManager(
    _ manager: CLLocationManager,
    didFailWithError error: Error
  ) {
    print("Location retrieving failed due to: \(error.localizedDescription)")
  }
}
