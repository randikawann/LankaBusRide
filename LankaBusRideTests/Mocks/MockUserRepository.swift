//
//  MockUserRepository.swift
//  LankaBusRideTests
//
//  Created by ranCreation on 2025-05-12.
//

import Foundation
@testable import LankaBusRide


final class MockUserRepository: UserRepositoryProtocol {
    var mockUser: User?

    func fetchUser(completion: @escaping (Result<User, Error>) -> Void) {
        if let user = mockUser {
            completion(.success(user))
        } else {
            completion(.failure(NSError(domain: "", code: -1)))
        }
    }
}
