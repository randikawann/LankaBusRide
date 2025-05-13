//
//  HomeViewModel.swift
//  LankaBusRide
//
//  Created by ranCreation on 2025-05-10.
//

import Foundation

class HomeViewModel: BindableViewModel {
    var isLoading: ((Bool) -> Void)?
    var didEncounterError: (((any Error)?) -> Void)?

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
        isLoading?(true)
        userRepository.fetchUser { [weak self] isSuccess, user, error in
            self?.isLoading?(false)
            if isSuccess, let user = user {
                self?.user = user
            } else {
                self?.didEncounterError?(error)
            }
        }
    }
    
    func loadRoutes() {
        isLoading?(true)
        busRepository.fetchRoutes { [weak self] isSuccess, routes, error in
            self?.isLoading?(false)
            if isSuccess, let routes = routes {
                self?.routes = routes
            } else {
                self?.didEncounterError?(error)
            }
        }
    }
}
