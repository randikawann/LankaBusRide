//
//  BusRouteDTO+Extensions.swift
//  LankaBusRide
//
//  Created by ranCreation on 2025-05-10.
//

import Foundation

extension BusRouteDTO {
    func toDomain() -> BusRoute {
        BusRoute(
            id: id,
            title: "\(company) | \(source) → \(destination)",
            timeRange: "\(departure) - \(arrival)"
        )
    }
}
