//
//  SearchViewModelTests.swift
//  LankaBusRideTests
//
//  Created by ranCreation on 2025-05-12.
//

import XCTest
@testable import LankaBusRide

final class SearchViewModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoadTopRoutes_success_setsTopRoutes() {
        // Given
        let mockRepository = MockBusRepository()
        mockRepository.mockRoutes = [
            BusRoute(id: 1, companyName: "Mock Co1", source: "A", destination: "B", departure: "6:00", arrival: "9:00", routeNumber: "100", duration: "3h"),
            BusRoute(id: 1, companyName: "Mock Co2", source: "B", destination: "D", departure: "6:00", arrival: "9:00", routeNumber: "101", duration: "3h"),
            BusRoute(id: 1, companyName: "Mock Co3", source: "A", destination: "B", departure: "6:00", arrival: "9:00", routeNumber: "100", duration: "3h"),
            BusRoute(id: 1, companyName: "Mock Co3", source: "B", destination: "C", departure: "6:00", arrival: "9:00", routeNumber: "102", duration: "3h"),
        ]
        
        let viewModel = SearchViewModel(busRepository: mockRepository)
        let expectation = self.expectation(description: "Completion called")
        
        // When
        viewModel.loadTopRoutes(limit: 2) {
            // Then
            XCTAssertEqual(viewModel.allRouteInfos.count, 2)
            XCTAssertEqual(viewModel.allBusRoutes.count, 4)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testSelectedRoute_filtersBusRoutesAndTriggersClosures() {
        // Given
        let route100 = BusRoute(id: 1, companyName: "Mock Co1", source: "A", destination: "B", departure: "6:00", arrival: "9:00", routeNumber: "100", duration: "3h")
        let route101 = BusRoute(id: 1, companyName: "Mock Co2", source: "B", destination: "D", departure: "6:00", arrival: "9:00", routeNumber: "101", duration: "3h")
        
        let mockRepository = MockBusRepository()
        let viewModel = SearchViewModel(busRepository: mockRepository)
        viewModel.setAllBusRoutes([route100, route101, route100])
        
        var routeNumberChanged = false
        var filteredRoutesChanged = false
        
        viewModel.routeNumberDidChange = { routeNumber in
            XCTAssertEqual(routeNumber, "100")
            routeNumberChanged = true
        }
        
        viewModel.filteredRoutesDidChange = {
            filteredRoutesChanged = true
        }
        
        // When
        viewModel.selectedRoute = RouteInfo(routeNumber: "100")
        
        // Then
        XCTAssertTrue(routeNumberChanged)
        XCTAssertTrue(filteredRoutesChanged)
        XCTAssertEqual(viewModel.filteredBusRoutes.count, 2)
    }
    
}
