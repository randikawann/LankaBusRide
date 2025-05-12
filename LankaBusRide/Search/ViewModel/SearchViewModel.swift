//
//  SearchViewModel.swift
//  LankaBusRide
//
//  Created by ranCreation on 2025-05-12.
//

import Foundation

class SearchViewModel {
    private(set) var allRouteInfos: [RouteInfo] = []
    private(set) var allBusRoutes: [BusRoute] = []
    
    var selectedRoute: RouteInfo? {
        didSet {
            routeNumberDidChange?(selectedRoute?.routeNumber ?? "")
            filterRoutes(for: selectedRoute)
        }
    }
    
    var filteredBusRoutes: [BusRoute] = [] {
        didSet {
            filteredRoutesDidChange?()
        }
    }
    
    var routeNumberDidChange: ((String) -> Void)?
    var filteredRoutesDidChange: (() -> Void)?
    
    private let busRepository: BusRepositoryProtocol
    
    init(busRepository: BusRepositoryProtocol = BusRepository()) {
        self.busRepository = busRepository
    }
    
    private func filterRoutes(for route: RouteInfo?) {
        if let route = route {
            filteredBusRoutes = allBusRoutes.filter { $0.routeNumber == route.routeNumber }
        } else {
            filteredBusRoutes = []
        }
    }
    
    func loadTopRoutes(limit: Int = 3, completion: @escaping () -> Void) {
        busRepository.fetchRoutes { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let routes):
                    let uniqueRoutes = Array(
                        Set(routes.map { RouteInfo(routeNumber: $0.routeNumber) })
                    )
                    let topRoutes = Array(uniqueRoutes.prefix(limit))
                    self?.allRouteInfos = topRoutes
                    self?.allBusRoutes = routes
                    
                case .failure(let error):
                    print("Error loading routes: \(error)")
                    self?.allRouteInfos = []
                }
                completion()
            }
        }
    }
}
