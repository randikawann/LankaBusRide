//
//  BusRoute+Extensions.swift
//  LankaBusRide
//
//  Created by ranCreation on 2025-05-12.
//

import Foundation

extension Array where Element == BusRoute {
    func filtered(by routeInfo: RouteInfo?) -> [BusRoute] {
        guard let routeInfo = routeInfo else { return [] }
        return self.filter { $0.routeNumber == routeInfo.routeNumber }
    }
}
