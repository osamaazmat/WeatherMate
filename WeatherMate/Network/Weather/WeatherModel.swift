//
//  WeatherModel.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 27/05/2022.
//

import Foundation

// MARK: - WeatherModel
struct WeatherModel: Codable {
    var coord: Coord?
    var weatherData: [WeatherDatum]?
    var base: String?
    var mainData: MainData?
    var visibility: Int?
    var wind: Wind?
    var clouds: Clouds?
    var dt: Int?
    var sys: Sys?
    var timezone, id: Int?
    var name: String?
    var cod: Int?
    
    enum CodingKeys: String, CodingKey {
        case coord
        case weatherData = "weather"
        case base
        case mainData = "main"
        case visibility
        case wind
        case clouds
        case dt
        case sys
        case timezone, id
        case name
        case cod
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    var all: Int?
}

// MARK: - Coord
struct Coord: Codable {
    var lon, lat: Double?
}

// MARK: - MainData
struct MainData: Codable {
    var temp, feelsLike, tempMin, tempMax: Double?
    var pressure, humidity: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys
struct Sys: Codable {
    var type, id: Int?
    var message: Double?
    var country: String?
    var sunrise, sunset: Int?
}

// MARK: - WeatherDatum
struct WeatherDatum: Codable {
    var id: Int?
    var main, weatherDescription, icon: String?

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Codable {
    var speed: Double?
    var deg: Int?
}
