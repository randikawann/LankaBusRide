//
//  HomeViewModel.swift
//  LankaBusRide
//
//  Created by ranCreation on 2025-05-10.
//

import Foundation

class HomeViewModel {
    private let repository: BusRepositoryProtocol
    private(set) var routes: [BusRoute] = []
    var onDataUpdate: (() -> Void)?

    init(repository: BusRepositoryProtocol = BusRepository()) {
        self.repository = repository
    }

    func fetchRoutes() {
        repository.fetchRoutes { [weak self] result in
            switch result {
            case .success(let routes):
                self?.routes = routes
                DispatchQueue.main.async {
                    self?.onDataUpdate?()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
