//
//  BikeStationsViewModel.swift
//  CityBikes
//
//  Created by Kacper Przybyła on 14/04/2024.
//

import Foundation
import Combine

final class BikeStationsViewModel: ObservableObject {
    
    @Published var allStations: [Station] = []
    
    private let dataService: StationsService
    private var cancellables = Set<AnyCancellable>()
    
    init(dataService: StationsService = StationsService()) {
        self.dataService = dataService
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$allStations
            .sink { [weak self] returnedStations in
                self?.allStations = returnedStations
            }
            .store(in: &cancellables)
    }
    
}
