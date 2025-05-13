//
//  DetailViewModel.swift
//  LankaBusRide
//
//  Created by ranCreation on 2025-05-13.
//

import Foundation

class DetailViewModel {
    
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
        busRepository.fetchBusDetails(busRouteId: id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let busDetail):
                    self?.busDetail = busDetail
                    
                case .failure(let error):
                    print("Error")
                }
                completion()
            }
        }
    }
    
}
