//
//  UserRepository.swift
//  LankaBusRide
//
//  Created by ranCreation on 2025-05-10.
//

import Foundation

protocol UserRepositoryProtocol {
    func fetchUser(completion: @escaping (Bool, User?, NetworkError?) -> Void)
}

final class UserRepository: UserRepositoryProtocol {
    private let apiManager = APIManager.shared
    
    func fetchUser(completion: @escaping (Bool, User?, NetworkError?) -> Void) {
        apiManager.request(endpoint: .getUserDetails) { (isSuccess: Bool, dto: UserDTO?, error: NetworkError?) in
            if isSuccess, let dto = dto {
                let user = dto.toDomain()
                completion(true, user, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
}
