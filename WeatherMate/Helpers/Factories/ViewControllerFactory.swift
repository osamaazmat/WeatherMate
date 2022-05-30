//
//  ViewControllerFactory.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 30/05/2022.
//

import Foundation

protocol ViewControllerFactoryProtocol: AnyObject {
    static func makeTabBar() -> TabBar
    static func makeLogin() -> LoginViewController
    static func makeHome() -> HomeViewController
    static func makeWeeklyForecast() -> WeeklyForecastViewController
    static func makeSettings() -> SettingsViewController
}

class ViewControllerFactory: ViewControllerFactoryProtocol {
    
    static func makeTabBar() -> TabBar {
        return TabBar()
    }
    
    static func makeLogin() -> LoginViewController {
        let viewModel = LoginViewModel(networkService: NetworkService.instance)
        let view = LoginViewController()
        view.viewModel = viewModel
        
        return view
    }
    
    static func makeHome() -> HomeViewController {
        let viewModel = HomeViewModel(networkService: NetworkService.instance)
        let view = HomeViewController()
        view.viewModel = viewModel
        return view
    }
    
    static func makeWeeklyForecast() -> WeeklyForecastViewController {
        let viewModel = WeeklyForecastViewModel(networkService: NetworkService.instance)
        let view = WeeklyForecastViewController()
        view.viewModel = viewModel
        return view
    }
    
    static func makeSettings() -> SettingsViewController {
        let viewModel = SettingsViewModel(networkService: NetworkService.instance)
        let view = SettingsViewController()
        view.viewModel = viewModel
        return view
    }
}
