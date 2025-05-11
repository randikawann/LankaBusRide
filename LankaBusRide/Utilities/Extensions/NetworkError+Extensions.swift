//
//  NetworkError+Extensions.swift
//  LankaBusRide
//
//  Created by ranCreation on 2025-05-10.
//

import Foundation

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .noData:
            return "No data was received from the server."
        case .decodingFailed:
            return "Failed to decode the response."
        case .unknown:
            return "An unknown network error occurred."
        }
    }
}
