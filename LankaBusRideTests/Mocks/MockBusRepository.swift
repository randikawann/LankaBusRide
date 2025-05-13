//
//  MockBusRepository.swift
//  LankaBusRideTests
//
//  Created by ranCreation on 2025-05-12.
//

import Foundation
@testable import LankaBusRide

final class MockBusRepository: BusRepositoryProtocol {
    var mockRoutes: [BusRoute] = []
    var mockBusDetail: BusDetail?
    var shouldReturnError = false
    
    func fetchRoutes(completion: @escaping (Bool, [BusRoute]?, NetworkError?) -> Void) {
        completion(true, mockRoutes, nil)
    }
    
    func fetchBusDetails(busRouteId: Int, completion: @escaping (Bool, BusDetail?, NetworkError?) -> Void) {
        if shouldReturnError {
            completion(false, nil, .noData)
        } else if let detail = mockBusDetail {
            completion(true, detail, nil)
        }
    }
}
