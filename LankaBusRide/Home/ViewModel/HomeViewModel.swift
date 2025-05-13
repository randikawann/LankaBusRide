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
        userRepository.fetchUser { [weak self] isSuccess, user, error in
            if isSuccess, let user = user {
                self?.user = user
            } else {
                print("Failed to fetch user:", error?.localizedDescription ?? "Unknown error")
            }
        }
    }
    
    func loadRoutes() {
        busRepository.fetchRoutes { [weak self] isSuccess, routes, error in
            if isSuccess, let routes = routes {
                self?.routes = routes
            } else {
                print("Failed to fetch routes:", error?.localizedDescription ?? "Unknown error")
            }
        }
    }
}
