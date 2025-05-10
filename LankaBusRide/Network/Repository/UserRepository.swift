//
//  UserRepository.swift
//  LankaBusRide
//
//  Created by ranCreation on 2025-05-10.
//

import Foundation

protocol UserRepositoryProtocol {
    func fetchUser(completion: @escaping (Result<User, Error>) -> Void)
}

final class UserRepository: UserRepositoryProtocol {
    private let apiManager = APIManager.shared
    
    func fetchUser(completion: @escaping (Result<User, any Error>) -> Void) {
        apiManager.request(endpoint: .getUserDetails) { (result: Result<UserDTO, Error>) in
            switch result {
            case .success(let dto):
                let user = dto.toDomain()
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
