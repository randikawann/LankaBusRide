//
//  Endpoints.swift
//  LankaBusRide
//
//  Created by ranCreation on 2025-05-10.
//

import Foundation

// Network/Endpoint.swift
enum Endpoint {
    case getRoutes

    var url: String {
        switch self {
        case .getRoutes:
            return "https://run.mocky.io/v3/d49642ef-179f-467c-8b3d-15918edcc166"
        }
    }
}
