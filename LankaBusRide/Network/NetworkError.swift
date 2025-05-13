//
//  NetworkError.swift
//  LankaBusRide
//
//  Created by ranCreation on 2025-05-10.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case custom(Error)
}
