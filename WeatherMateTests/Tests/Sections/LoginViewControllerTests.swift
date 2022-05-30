//
//  LoginViewControllerTests.swift
//  WeatherMateTests
//
//  Created by Osama Azmat Khan on 31/05/2022.
//

import Foundation
import XCTest
import CoreLocation

@testable import WeatherMate

class LoginViewControllerTests: XCTestCase {
    
    var loginViewController: LoginViewController!
    
    override func setUp() {
        LoginManager.instance.logOut()
        CacheManager.instance.removeAllData()
        AppRouter.moveToLogin(withNavigationController: nil)
        loginViewController = MockViewControllerFactory.makeLogin()
        loginViewController.currentLocation = CLLocationCoordinate2D(latitude: 33.738045, longitude: 73.084488)
        loginViewController.screenType = .autoLogin
        loginViewController.loadView()
    }
    
    override func tearDown() {
        loginViewController.viewModel = nil
        loginViewController = nil
    }
}

// MARK: UI Test Cases
extension LoginViewControllerTests {
    
    func testOutlets() {
        XCTAssertNotNil(loginViewController.mainImageView)
        XCTAssertNotNil(loginViewController.emailTextField)
        XCTAssertNotNil(loginViewController.passwordTextField)
        XCTAssertNotNil(loginViewController.loginSignUpButton)
        XCTAssertNotNil(loginViewController.mainImageViewCenterConstraint)
        XCTAssertNotNil(loginViewController.crossButton)
        XCTAssertNotNil(loginViewController.mainStackView)
        XCTAssertNotNil(loginViewController.goToSignupButton)
    }
    
    func testScreenTypes() {
        loginViewController = nil
        loginViewController = MockViewControllerFactory.makeLogin()
        loginViewController.loadView()
        loginViewController.screenType = .autoLogin
        loginViewController.viewDidLoad()
        XCTAssertEqual(loginViewController.loginSignUpButton.isHidden, true)
        
        loginViewController = nil
        loginViewController = MockViewControllerFactory.makeLogin()
        loginViewController.loadView()
        loginViewController.screenType = .signup
        loginViewController.viewDidLoad()
        XCTAssertEqual(loginViewController.loginSignUpButton.titleLabel?.text, loginViewController.screenType.labelText)
        
        loginViewController = nil
        loginViewController = MockViewControllerFactory.makeLogin()
        loginViewController.loadView()
        loginViewController.screenType = .login
        loginViewController.viewDidLoad()
        XCTAssertEqual(loginViewController.loginSignUpButton.titleLabel?.text, loginViewController.screenType.labelText)
    }
}

// MARK: Login Signup TestCases
extension LoginViewControllerTests {
    
    func testAutoLoginSuccess() {
        let _ = CacheManager.instance.saveUserData(email: "usama.azmat@hotmail.com", password: "12345678")
        loginViewController.tryAutoLogin()
        
        let timeInSeconds = 4.0
        let expectation = XCTestExpectation(description: "User Will Be Logged In")

        DispatchQueue.main.asyncAfter(deadline: .now() + timeInSeconds) {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: timeInSeconds)

        // do your XCTAssertions here
        XCTAssertTrue(UIApplication.shared.mainKeyWindow?.rootViewController is UITabBarController)
    }
    
    func testAutoLoginAPIFailure() {
        let _ = CacheManager.instance.saveUserData(email: "notrealuser@hotmail.com", password: "1111111111")
        loginViewController.tryAutoLogin()
        
        let timeInSeconds = 6.0
        let expectation = XCTestExpectation(description: "User Will Not Be Logged In")

        DispatchQueue.main.asyncAfter(deadline: .now() + timeInSeconds) {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: timeInSeconds)

        // do your XCTAssertions here
        XCTAssertTrue(UIApplication.shared.mainKeyWindow?.rootViewController is LoginViewController)
    }
    
    func testAutoLoginCacheFailure() {
        loginViewController.tryAutoLogin()
        
        let timeInSeconds = 6.0
        let expectation = XCTestExpectation(description: "User Will Not Be Logged In")

        DispatchQueue.main.asyncAfter(deadline: .now() + timeInSeconds) {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: timeInSeconds)

        // do your XCTAssertions here
        XCTAssertTrue(UIApplication.shared.mainKeyWindow?.rootViewController is LoginViewController)
    }
    
    func testLoginSuccess() {
        let email = "usama.azmat@hotmail.com"
        let password = "12345678"
        loginViewController.login(with: email, password: password)
        
        let timeInSeconds = 4.0
        let expectation = XCTestExpectation(description: "User Will Be Logged In")

        DispatchQueue.main.asyncAfter(deadline: .now() + timeInSeconds) {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: timeInSeconds)

        // do your XCTAssertions here
        XCTAssertTrue(UIApplication.shared.mainKeyWindow?.rootViewController is UITabBarController)
    }

    func testLoginAPIFailure() {
        let email = "notrealuser@hotmail.com"
        let password = "12345678"
        loginViewController.login(with: email, password: password)
        
        let timeInSeconds = 6.0
        let expectation = XCTestExpectation(description: "User Will Not Be Logged In")

        DispatchQueue.main.asyncAfter(deadline: .now() + timeInSeconds) {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: timeInSeconds)

        // do your XCTAssertions here
        XCTAssertTrue(UIApplication.shared.mainKeyWindow?.rootViewController is LoginViewController)
    }
    
    func testSignUpSuccess() {
        let dateTime = Date().timeIntervalSince1970
        let email = "testuser\(dateTime)@hotmail.com"
        let password = "12345678"
        loginViewController.signUp(with: email, password: password)
        
        let timeInSeconds = 4.0
        let expectation = XCTestExpectation(description: "User Will Be Signed Up")

        DispatchQueue.main.asyncAfter(deadline: .now() + timeInSeconds) {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: timeInSeconds)

        // do your XCTAssertions here
        XCTAssertTrue(UIApplication.shared.mainKeyWindow?.rootViewController is UITabBarController)
    }
    
    func testSignUpFailureUserExists() {
        let email = "usama.azmat@hotmail.com"
        let password = "12345678"
        loginViewController.signUp(with: email, password: password)
        
        let timeInSeconds = 6.0
        let expectation = XCTestExpectation(description: "User Will Not Be Signed Up")

        DispatchQueue.main.asyncAfter(deadline: .now() + timeInSeconds) {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: timeInSeconds)

        // do your XCTAssertions here
        XCTAssertTrue(UIApplication.shared.mainKeyWindow?.rootViewController is LoginViewController)
    }
}
