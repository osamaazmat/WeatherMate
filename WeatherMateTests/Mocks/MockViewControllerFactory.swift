//
//  MockViewControllerFactory.swift
//  WeatherMateTests
//
//  Created by Osama Azmat Khan on 31/05/2022.
//

import Foundation

class MockViewControllerFactory: ViewControllerFactoryProtocol {
    
    static func makeTabBar() -> TabBar {
        return TabBar()
    }
    
    static func makeLogin() -> LoginViewController {
        let viewModel = LoginViewModel(networkService: MockNetworkService.instance)
        let view = LoginViewController()
        view.viewModel = viewModel
        
        return view
    }
    
    static func makeHome() -> HomeViewController {
        let viewModel = HomeViewModel(networkService: MockNetworkService.instance)
        let view = HomeViewController()
        view.viewModel = viewModel
        return view
    }
    
    static func makeWeeklyForecast() -> WeeklyForecastViewController {
        let viewModel = WeeklyForecastViewModel(networkService: MockNetworkService.instance)
        let view = WeeklyForecastViewController()
        view.viewModel = viewModel
        return view
    }
    
    static func makeSettings() -> SettingsViewController {
        let viewModel = SettingsViewModel(networkService: MockNetworkService.instance)
        let view = SettingsViewController()
        view.viewModel = viewModel
        return view
    }
}

// MARK: Failure
extension MockViewControllerFactory {
    
    static func makeHomeFailure() -> HomeViewController {
        let viewModel = HomeViewModel(networkService: MockNetworkServiceFailure.instance)
        let view = HomeViewController()
        view.viewModel = viewModel
        return view
    }
    
    static func makeWeeklyForecastFailure() -> WeeklyForecastViewController {
        let viewModel = WeeklyForecastViewModel(networkService: MockNetworkServiceFailure.instance)
        let view = WeeklyForecastViewController()
        view.viewModel = viewModel
        return view
    }
}
