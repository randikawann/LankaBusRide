//
//  SearchViewModel.swift
//  LankaBusRide
//
//  Created by ranCreation on 2025-05-12.
//

import Foundation

class SearchViewModel {
    typealias RouteNumberChangeHandler = (String) -> Void
    typealias FilteredRoutesChangeHandler = () -> Void
    typealias ErrorHandler = (Error) -> Void
    
    private(set) var allRouteInfos: [RouteInfo] = []
    private(set) var allBusRoutes: [BusRoute] = []
    
    var selectedRoute: RouteInfo? {
        didSet {
            handleRouteSelection()
        }
    }
    
    var filteredBusRoutes: [BusRoute] = [] {
        didSet {
            filteredRoutesDidChange?()
        }
    }
    
    var routeNumberDidChange: RouteNumberChangeHandler?
    var filteredRoutesDidChange: FilteredRoutesChangeHandler?
    var didEncounterError: ErrorHandler?
    
    private let busRepository: BusRepositoryProtocol
    
    init(busRepository: BusRepositoryProtocol = BusRepository()) {
        self.busRepository = busRepository
    }
    
#if DEBUG
    func setAllBusRoutes(_ routes: [BusRoute]) {
        self.allBusRoutes = routes
    }
#endif
    
    private func handleRouteSelection() {
        routeNumberDidChange?(selectedRoute?.routeNumber ?? "")
        filterRoutes(for: selectedRoute)
    }
    
    private func filterRoutes(for route: RouteInfo?) {
        if let route = route {
            filteredBusRoutes = allBusRoutes.filteredByRoute(by: route)
        } else {
            filteredBusRoutes = []
        }
    }
    
    func loadTopRoutes(limit: Int = 3, completion: @escaping () -> Void) {
        busRepository.fetchRoutes { [weak self] isSuccess, routes, error in
            DispatchQueue.main.async {
                if isSuccess, let routes = routes {
                    let uniqueRoutes = Array(
                        Set(routes.map { RouteInfo(routeNumber: $0.routeNumber) })
                    )
                    let topRoutes = Array(uniqueRoutes.prefix(limit))
                    self?.allRouteInfos = topRoutes
                    self?.allBusRoutes = routes
                } else {
                    if error != nil {
                        self?.didEncounterError?(error!)
                    }
                    self?.allRouteInfos = []
                    self?.allBusRoutes = []
                }
                completion()
            }
        }
    }
}
