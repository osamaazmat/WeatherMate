//
//  WeatherManager.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 28/05/2022.
//

import Foundation
import UIKit

enum WeatherType {
    case thunderStorm
    case drizzle
    case rain
    case snow
    case atmosphere(id: Int)
    case clear
    case clouds
    case unknown
    
    func getBackgroundImage() -> UIImage {
        switch self {
        case .thunderStorm:
            return UIImage.init(named: "weather_thunderStorm") ?? UIImage()
        case .drizzle:
            return UIImage.init(named: "weather_drizzle") ?? UIImage()
        case .rain:
            return UIImage.init(named: "weather_rainy") ?? UIImage()
        case .snow:
            return UIImage.init(named: "weather_snowy") ?? UIImage()
        case .atmosphere:
            return UIImage.init(named: "weather_atmosphere") ?? UIImage()
        case .clear:
            return UIImage.init(named: "weather_clear") ?? UIImage()
        case .clouds:
            return UIImage.init(named: "weather_cloudy") ?? UIImage()
        case .unknown:
            return UIImage.init(named: "weather_clear") ?? UIImage()
        }
    }
}

class WeatherManager {
    
    var weatherType: WeatherType {
        didSet {
            NotificationCenter.default.post(name: Notification.Name(NotificationNames.weatherDidUpdateNotification), object: self, userInfo: nil)
        }
    }
    
    static let instance = WeatherManager()
    private init() {
        weatherType = .unknown
    }
    
    func setWeatherType(with conditionID: Int) {
        switch conditionID {
        case 200..<300:
            print("Thunderstorm")
            weatherType = .thunderStorm
        case 300..<400:
            print("Drizzle")
            weatherType = .drizzle
        case 500..<600:
            print("Rain")
            weatherType = .rain
        case 600..<700:
            print("Snow")
            weatherType = .snow
        case 700..<800:
            print("Atmosphere")
            weatherType = .atmosphere(id: conditionID)
        case 800:
            print("Clear")
            weatherType = .clear
        case 801..<900:
            print("Clouds")
            weatherType = .clouds
        default:
            print("Unknown")
            weatherType = .unknown
        }
    }
}
