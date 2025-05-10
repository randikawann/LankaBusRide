//
//  Endpoints.swift
//  LankaBusRide
//
//  Created by ranCreation on 2025-05-10.
//

import Foundation

enum Endpoint {
    case getRoutes
    case getUserDetails
    
    var url: String {
        switch self {
        case .getRoutes:
            return "https://run.mocky.io/v3/d49642ef-179f-467c-8b3d-15918edcc166"
        case .getUserDetails:
            return "https://run.mocky.io/v3/ca6dc778-ae2d-49db-bd65-11e4f0c2f2de"
        }
    }
}
