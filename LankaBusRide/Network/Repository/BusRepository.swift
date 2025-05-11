//
//  BusRepository.swift
//  LankaBusRide
//
//  Created by ranCreation on 2025-05-10.
//

import Foundation

protocol BusRepositoryProtocol {
    func fetchRoutes(completion: @escaping (Result<[BusRoute], Error>) -> Void)
}

final class BusRepository: BusRepositoryProtocol {
    private let apiManager = APIManager.shared
    
    func fetchRoutes(completion: @escaping (Result<[BusRoute], Error>) -> Void) {
        apiManager.request(endpoint: .getRoutes) { (result: Result<[BusRouteDTO], Error>) in
            switch result {
            case .success(let dtoList):
                let domainList = dtoList.map { $0.toDomain() }
                completion(.success(domainList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

