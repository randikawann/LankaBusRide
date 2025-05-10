//
//  HomeViewModel.swift
//  LankaBusRide
//
//  Created by ranCreation on 2025-05-10.
//

import Foundation

class HomeViewModel {
    private let busRepository: BusRepositoryProtocol
    private let userRepository: UserRepositoryProtocol
    var onUserDataUpdate: (() -> Void)?
    var onRoutesDataUpdate: (() -> Void)?
    
    var user: User? {
        didSet { onUserDataUpdate?() }
    }
    
    var routes: [BusRoute] = [] {
        didSet { onRoutesDataUpdate?() }
    }
    
    init(busRepository: BusRepositoryProtocol = BusRepository(), userRepository: UserRepositoryProtocol = UserRepository() ) {
        self.busRepository = busRepository
        self.userRepository = userRepository
    }
    
    func loadUser() {
        userRepository.fetchUser { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
            case .failure(let error):
                print("Failed to fetch user:", error)
            }
        }
    }
    
    func loadRoutes() {
        busRepository.fetchRoutes { [weak self] result in
            switch result {
            case .success(let routes):
                self?.routes = routes
            case .failure(let error):
                print("Failed to fetch routes:", error)
            }
        }
    }
}
