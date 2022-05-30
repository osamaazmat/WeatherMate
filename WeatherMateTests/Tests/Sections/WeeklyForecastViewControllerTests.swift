//
//  WeeklyForecastViewControllerTests.swift
//  WeatherMateTests
//
//  Created by Osama Azmat Khan on 31/05/2022.
//

import Foundation
import XCTest
import CoreLocation

@testable import WeatherMate

class WeeklyForecastViewControllerTests: XCTestCase {
    
    var weeklyForecastViewController: WeeklyForecastViewController!
    
    override func setUp() {
        weeklyForecastViewController = MockViewControllerFactory.makeWeeklyForecast()
        weeklyForecastViewController.currentLocation = CLLocationCoordinate2D(latitude: 33.738045, longitude: 73.084488)
        weeklyForecastViewController.loadView()
    }
    
    override func tearDown() {
        weeklyForecastViewController.viewModel = nil
        weeklyForecastViewController = nil
    }
}

// MARK: UI Test Cases
extension WeeklyForecastViewControllerTests {
    
    func testOutlets() {
        XCTAssertNotNil(weeklyForecastViewController.tableView)
        XCTAssertNotNil(weeklyForecastViewController.mainImageView)
    }
    
    func testGetWeatherDataSuccess() {
        weeklyForecastViewController.viewDidLoad()
        
        let timeInSeconds = 5.0
        let expectation = XCTestExpectation(description: "Weather Data Will be Recieved")

        DispatchQueue.main.asyncAfter(deadline: .now() + timeInSeconds) {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: timeInSeconds)

        // do your XCTAssertions here
        XCTAssert(weeklyForecastViewController.tableView.numberOfRows(inSection: 0) > 5)
    }
    
    func testGetWeatherDataFailure() {
        weeklyForecastViewController = MockViewControllerFactory.makeWeeklyForecastFailure()
        weeklyForecastViewController.currentLocation = CLLocationCoordinate2D(latitude: 33.738045, longitude: 73.084488)
        weeklyForecastViewController.loadView()
        weeklyForecastViewController.viewDidLoad()
        
        let timeInSeconds = 5.0
        let expectation = XCTestExpectation(description: "Weather Data Will be Recieved")

        DispatchQueue.main.asyncAfter(deadline: .now() + timeInSeconds) {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: timeInSeconds)

        // do your XCTAssertions here
        XCTAssert(weeklyForecastViewController.tableView.numberOfRows(inSection: 0) == 0)
    }
}
