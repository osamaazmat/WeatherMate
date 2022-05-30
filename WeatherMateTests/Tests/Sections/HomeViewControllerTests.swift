//
//  HomeViewControllerTests.swift
//  WeatherMateTests
//
//  Created by Osama Azmat Khan on 31/05/2022.
//

import Foundation
import XCTest
import CoreLocation

@testable import WeatherMate

class HomeViewControllerTests: XCTestCase {
    
    var homeViewController: HomeViewController!
    
    override func setUp() {
        homeViewController = MockViewControllerFactory.makeHome()
        homeViewController.currentLocation = CLLocationCoordinate2D(latitude: 33.738045, longitude: 73.084488)
        homeViewController.loadView()
    }
    
    override func tearDown() {
        homeViewController.viewModel = nil
        homeViewController = nil
    }
}

// MARK: UI Test Cases
extension HomeViewControllerTests {
    
    func testOutlets() {
        XCTAssertNotNil(homeViewController.scrollView)
        XCTAssertNotNil(homeViewController.mainImageView)
        XCTAssertNotNil(homeViewController.cityLabel)
        XCTAssertNotNil(homeViewController.currentTempLabel)
        XCTAssertNotNil(homeViewController.weatherDescriptionLabel)
        XCTAssertNotNil(homeViewController.windSpeedLabel)
        XCTAssertNotNil(homeViewController.windDirectionLabel)
        XCTAssertNotNil(homeViewController.windPressureLabel)
        XCTAssertNotNil(homeViewController.humidityLabel)
        XCTAssertNotNil(homeViewController.minMaxTempLabel)
        XCTAssertNotNil(homeViewController.topConstraint)
    }
    
    func testGetWeatherDataSuccess() {
        homeViewController.viewDidLoad()
        
        let timeInSeconds = 5.0
        let expectation = XCTestExpectation(description: "Weather Data Will be Recieved")

        DispatchQueue.main.asyncAfter(deadline: .now() + timeInSeconds) {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: timeInSeconds)

        // do your XCTAssertions here
        XCTAssertNotEqual(homeViewController.currentTempLabel.text, "--")
    }
    
    func testGetWeatherDataFailure() {
        homeViewController = MockViewControllerFactory.makeHomeFailure()
        homeViewController.currentLocation = CLLocationCoordinate2D(latitude: 33.738045, longitude: 73.084488)
        homeViewController.loadView()
        homeViewController.viewDidLoad()
        
        let timeInSeconds = 5.0
        let expectation = XCTestExpectation(description: "Weather Data Will be Recieved")

        DispatchQueue.main.asyncAfter(deadline: .now() + timeInSeconds) {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: timeInSeconds)

        // do your XCTAssertions here
        XCTAssertEqual(homeViewController.currentTempLabel.text, "--")
    }
}
