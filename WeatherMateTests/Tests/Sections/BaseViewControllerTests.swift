//
//  BaseViewControllerTests.swift
//  WeatherMateTests
//
//  Created by Osama Azmat Khan on 31/05/2022.
//

import Foundation
import XCTest

class BaseViewControllerTests: XCTestCase {
    
    var baseViewController: BaseViewController!
    
    override func setUp() {
        baseViewController = BaseViewController.init()
        baseViewController.loadView()
    }
    
    override func tearDown() {
        baseViewController = nil
    }

    func testBasicFunctionality() {
        baseViewController.viewDidLoad()
    }
}
