//
//  BusRepository.swift
//  LankaBusRide
//
//  Created by ranCreation on 2025-05-10.
//

import Foundation

protocol BusRepositoryProtocol {
    func fetchRoutes(completion: @escaping (Result<[BusRoute], Error>) -> Void)
    func fetchBusDetails(busRouteId: Int, completion: @escaping (Result<BusDetail?, Error>) -> Void)
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
    
//TODO: Due to the api limitation getvalue from above api and filter details according to the selected id. Need to change it with proper api for the later development.
    func fetchBusDetails(busRouteId: Int, completion: @escaping (Result<BusDetail?, Error>) -> Void) {
        apiManager.request(endpoint: .getRoutes) { (result: Result<[BusRouteDTO], Error>) in
            switch result {
            case .success(let dtoList):
                let domainList = dtoList.map { $0.toDomainDetail() }
                let busDetail = domainList.first {$0.id == busRouteId}
                completion(.success(busDetail ?? nil))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

