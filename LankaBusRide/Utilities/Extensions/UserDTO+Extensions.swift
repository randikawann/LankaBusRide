//
//  UserDTO+Extensions.swift
//  LankaBusRide
//
//  Created by ranCreation on 2025-05-10.
//

import Foundation

extension UserDTO {
    func toDomain() -> User {
        return User(id: self.id, name: self.name, email: self.email)
    }
}
