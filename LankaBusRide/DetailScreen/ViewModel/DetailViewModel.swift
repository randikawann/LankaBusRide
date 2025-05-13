//
//  DetailViewModel.swift
//  LankaBusRide
//
//  Created by ranCreation on 2025-05-13.
//

import Foundation

class DetailViewModel: BindableViewModel {
    var isLoading: ((Bool) -> Void)?
    
    var didEncounterError: (((any Error)?) -> Void)?
    
    private(set) var busDetail: BusDetail?
    
    var source: String {
        busDetail?.source ?? "-"
    }
    
    var destination: String {
        busDetail?.destination ?? "-"
    }
    
    var departure: String {
        busDetail?.departure ?? "-"
    }
    
    var arrival: String {
        busDetail?.arrival ?? "-"
    }
    
    var routeNumber: String {
        busDetail?.routeNumber ?? "-"
    }
    
    var busType: String {
        busDetail?.busType ?? "-"
    }
    
    var duration: String {
        busDetail?.duration ?? "-"
    }
    
    var fareText: String {
        if let fare = busDetail?.fare {
            return "LKR \(fare)"
        }
        return "N/A"
    }
    
    var popularStops: String {
        busDetail?.popularStops.joined(separator: ", ") ?? "-"
    }
    
    var title: String {
        busDetail?.title ?? "Bus Details"
    }
    
    private let busRepository: BusRepositoryProtocol
    
    init(busRepository: BusRepositoryProtocol = BusRepository()) {
        self.busRepository = busRepository
    }
    
    func loadBusDetail(id: Int = 1, completion: @escaping () -> Void) {
        isLoading?(true)
        busRepository.fetchBusDetails(busRouteId: id) { [weak self] isSuccess, busDetail, error in
            DispatchQueue.main.async {
                self?.isLoading?(false)
                if isSuccess, let busDetail = busDetail {
                    self?.busDetail = busDetail
                } else {
                    self?.didEncounterError?(error)
                }
                completion()
            }
        }
    }
    
}
