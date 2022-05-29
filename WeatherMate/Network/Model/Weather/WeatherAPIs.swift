//
//  WeatherAPIs.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 27/05/2022.
//

import Foundation
import Alamofire

enum WeatherAPIs: URLRequestBuilder {
    case getWeatherData(lat: String, lon: String, exclude: String)
    case getForecastData(lat: String, lon: String, exclude: String)
}

extension WeatherAPIs {
    var path: String {
        switch self {
        case .getWeatherData:
            return Path.Weather.getWeatherData
        case .getForecastData:
            return Path.Weather.getForecastData
        }
    }
}

extension WeatherAPIs {
    var parameters: Parameters? {
        switch self {
        case .getWeatherData(let lat, let lon, let exclude):
            return [
                "lat": lat,
                "lon": lon,
                "exclude": exclude,
                "units": "metric",
                "appid": AppKeys.API_Key
            ]
        case .getForecastData(lat: let lat, lon: let lon, exclude: let exclude):
            return [
                "lat": lat,
                "lon": lon,
                "exclude": exclude,
                "units": "metric",
                "appid": AppKeys.API_Key
            ]
        }
    }
}

extension WeatherAPIs {
    var method: HTTPMethod {
        switch self {
        case .getWeatherData:
            return HTTPMethod.get
        case .getForecastData:
            return HTTPMethod.get
        }
    }
}
