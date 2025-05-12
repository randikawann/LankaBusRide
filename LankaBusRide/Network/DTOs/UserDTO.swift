//
//  UserDTO.swift
//  LankaBusRide
//
//  Created by ranCreation on 2025-05-10.
//

import Foundation

struct UserDTO: Codable {
    let id: Int
    let name: String
    let email: String
    let profilePictureURL: String?
}
