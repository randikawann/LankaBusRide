//
//  DetailViewModelTests.swift
//  LankaBusRideTests
//
//  Created by ranCreation on 2025-05-13.
//

import XCTest
@testable import LankaBusRide

final class DetailViewModelTests: XCTestCase {
    
    func testLoadBusDetail_Success_PopulatesViewModel() {
        // Given
        let mockRepository = MockBusRepository()
        mockRepository.mockBusDetail = BusDetail(
            id: 1,
            title: "Test Title",
            companyName: "TestCo",
            source: "Colombo",
            destination: "Kandy",
            departure: "08:00 AM",
            arrival: "11:00 AM",
            routeNumber: "100",
            duration: "3h",
            popularStops: ["Stop A", "Stop B"],
            fare: 300,
            busType: "AC"
        )
        let viewModel = DetailViewModel(busRepository: mockRepository)
        
        let expectation = self.expectation(description: "Bus detail loaded")
        
        // When
        viewModel.loadBusDetail(id: 1) {
            // Then
            XCTAssertEqual(viewModel.title, "Test Title")
            XCTAssertEqual(viewModel.source, "Colombo")
            XCTAssertEqual(viewModel.destination, "Kandy")
            XCTAssertEqual(viewModel.departure, "08:00 AM")
            XCTAssertEqual(viewModel.arrival, "11:00 AM")
            XCTAssertEqual(viewModel.routeNumber, "100")
            XCTAssertEqual(viewModel.duration, "3h")
            XCTAssertEqual(viewModel.fareText, "LKR 300")
            XCTAssertEqual(viewModel.popularStops, "Stop A, Stop B")
            XCTAssertEqual(viewModel.busType, "AC")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testLoadBusDetail_Error_KeepsDefaultValues() {
        // Given
        let mockRepository = MockBusRepository()
        mockRepository.shouldReturnError = true
        let viewModel = DetailViewModel(busRepository: mockRepository)
        
        let expectation = self.expectation(description: "Bus detail load failed")
        
        // When
        viewModel.loadBusDetail(id: 1) {
            // Then
            XCTAssertEqual(viewModel.title, "Bus Details")
            XCTAssertEqual(viewModel.source, "-")
            XCTAssertEqual(viewModel.fareText, "N/A")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
