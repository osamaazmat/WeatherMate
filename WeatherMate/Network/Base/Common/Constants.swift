//
//  Constants.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 27/05/2022.
//

import Foundation

enum AppKeys {
    static let API_Key = "f4487ac6d0c12d1e935291706da2f64f"
}

enum Path {
    enum Weather {
        public static let getWeatherData = "data/2.5/weather"
        public static let getForecastData = "data/2.5/onecall"
    }
}

enum NotificationNames {
    static let kLocationDidChangeNotification = "LocationDidChangeNotification"
    static let weatherDidUpdateNotification = "WeatherDidUpdateNotification"
}
