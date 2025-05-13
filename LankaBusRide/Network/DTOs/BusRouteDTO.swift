//
//  BusRouteDTO.swift
//  LankaBusRide
//
//  Created by ranCreation on 2025-05-10.
//

import Foundation

struct BusRouteDTO: Codable {
    let id: Int
    let company: String
    let source: String
    let destination: String
    let departure: String
    let arrival: String
    let routeNumber: String
    let duration: String
    let popularStops: [String]
    let fare: Int
    let busType: String
}
