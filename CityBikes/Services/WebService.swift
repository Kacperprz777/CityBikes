//
//  WebService.swift
//  CityBikes
//
//  Created by Kacper Przybyła on 14/04/2024.
//

import Foundation
import Combine

final class StationsService {
    
    @Published var allStations: [Station] = []
    private var stationSubscription: AnyCancellable?
    
    init() {
        getStations()
    }
    
    private func getStations() {
        
        guard let url = URL(string: "https://api.citybik.es/v2/networks/veturilo-nextbike-warsaw") else {
            return
        }
        
        stationSubscription = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { (output) -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: CityBikesResponse.self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] (returnedStations) in
                self?.allStations = returnedStations.network.stations
                self?.stationSubscription?.cancel()
            }
        
        
    }
}
