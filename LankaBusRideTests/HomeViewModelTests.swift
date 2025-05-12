//
//  HomeViewModelTests.swift
//  LankaBusRideTests
//
//  Created by ranCreation on 2025-05-12.
//

import Foundation
import XCTest
@testable import LankaBusRide

final class HomeViewModelTests: XCTestCase {

    func test_loadData_setsUserAndRoutes() {
        // Arrange
        let expectedUser = User(id: 1, name: "Test User", email: "randika@email.com")
        let expectedRoutes = [
            BusRoute(id: 1, companyName: "Mock Co", source: "A", destination: "B", departure: "6:00", arrival: "9:00", routeNumber: "MOCK1", duration: "3h")
        ]
        let mockUserRepo = MockUserRepository()
        mockUserRepo.mockUser = expectedUser

        let mockBusRepo = MockBusRepository()
        mockBusRepo.mockRoutes = expectedRoutes

        let viewModel = HomeViewModel(busRepository: mockBusRepo, userRepository: mockUserRepo)

        let expectationUser = expectation(description: "User loaded")
        let expectationRoutes = expectation(description: "Routes loaded")

        // Act
        viewModel.loadUser()
        viewModel.loadRoutes()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if viewModel.user != nil { expectationUser.fulfill() }
            if !viewModel.routes.isEmpty { expectationRoutes.fulfill() }
        }

        // Assert
        wait(for: [expectationUser, expectationRoutes], timeout: 1.0)

        XCTAssertEqual(viewModel.user?.name, expectedUser.name)
        XCTAssertEqual(viewModel.routes.count, expectedRoutes.count)
    }
}
