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
    
    func fetchRoutes(completion: @escaping (Result<[BusRoute], Error>) -> Void) {
        completion(.success(mockRoutes))
    }
    
    func fetchBusDetails(busRouteId: Int, completion: @escaping (Result<LankaBusRide.BusDetail?, any Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "Test", code: 1, userInfo: nil)))
        } else if let detail = mockBusDetail {
            completion(.success(detail))
        }
    }
}
