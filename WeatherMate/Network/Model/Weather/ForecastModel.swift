//
//  ForecastModel.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 28/05/2022.
//

import Foundation

// MARK: - ForecastModel
struct ForecastModel: Codable, BaseModelProtocol {
    
    func getMock() -> String {
        return ModelMocks.forecastModel
    }
    
    var lat, lon: Double?
    var timezone: String?
    var timezoneOffset: Double?
    var current: Current?
    var daily: [Daily]?

    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current, daily
    }
    
    init(from decoder: Decoder) throws {
        let values          = try decoder.container(keyedBy: CodingKeys.self)
        self.lat            = try values.decodeIfPresent(Double.self, forKey: .lat) ?? 0
        self.lon            = try values.decodeIfPresent(Double.self, forKey: .lon) ?? 0
        self.timezone       = try values.decodeIfPresent(String.self, forKey: .timezone) ?? ""
        self.timezoneOffset = try values.decodeIfPresent(Double.self, forKey: .timezoneOffset) ?? 0
        self.current        = try values.decodeIfPresent(Current.self, forKey: .current) ?? Current()
        self.daily          = try values.decodeIfPresent([Daily].self, forKey: .daily) ?? []
    }
}

// MARK: - Current
struct Current: Codable {
    var dt, sunrise, sunset: Double?
    var temp, feelsLike: Double?
    var pressure, humidity: Double?
    var dewPoint: Double?
    var uvi, clouds, visibility: Double?
    var windSpeed: Double?
    var windDeg: Double?
    var windGust: Double?
    var weather: [Weather]?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather
    }
    
    init(from decoder: Decoder) throws {
        let values      = try decoder.container(keyedBy: CodingKeys.self)
        self.dt         = try values.decodeIfPresent(Double.self, forKey: .dt) ?? 0
        self.sunrise    = try values.decodeIfPresent(Double.self, forKey: .sunrise) ?? 0
        self.sunset     = try values.decodeIfPresent(Double.self, forKey: .sunset) ?? 0
        self.temp       = try values.decodeIfPresent(Double.self, forKey: .temp) ?? 0
        self.feelsLike  = try values.decodeIfPresent(Double.self, forKey: .feelsLike) ?? 0
        self.pressure   = try values.decodeIfPresent(Double.self, forKey: .pressure) ?? 0
        self.humidity   = try values.decodeIfPresent(Double.self, forKey: .humidity) ?? 0
        self.dewPoint   = try values.decodeIfPresent(Double.self, forKey: .dewPoint) ?? 0
        self.uvi        = try values.decodeIfPresent(Double.self, forKey: .uvi) ?? 0
        self.clouds     = try values.decodeIfPresent(Double.self, forKey: .clouds) ?? 0
        self.visibility = try values.decodeIfPresent(Double.self, forKey: .visibility) ?? 0
        self.windSpeed  = try values.decodeIfPresent(Double.self, forKey: .windSpeed) ?? 0
        self.windDeg    = try values.decodeIfPresent(Double.self, forKey: .windDeg) ?? 0
        self.windGust   = try values.decodeIfPresent(Double.self, forKey: .windGust) ?? 0
        self.weather    = try values.decodeIfPresent([Weather].self, forKey: .weather) ?? []
    }
    
    init() {
        self.dt = 0
        self.sunrise = 0
        self.sunset = 0
        self.temp = 0
        self.feelsLike = 0
        self.pressure = 0
        self.humidity = 0
        self.dewPoint = 0
        self.uvi = 0
        self.clouds = 0
        self.visibility = 0
        self.windSpeed = 0
        self.windDeg = 0
        self.windGust = 0
        self.weather = []
    }
}

// MARK: - Weather
struct Weather: Codable {
    var id: Double?
    var main, weatherDescription, icon: String?

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Daily
struct Daily: Codable {
    var dt, sunrise, sunset, moonrise: Double?
    var moonset: Double?
    var moonPhase: Double?
    var temp: Temp?
    var feelsLike: FeelsLike?
    var pressure, humidity: Double?
    var dewPoint, windSpeed: Double?
    var windDeg: Double?
    var windGust: Double?
    var weather: [Weather]?
    var clouds: Double?
    var pop, rain, uvi: Double?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, clouds, pop, rain, uvi
    }
    
    init(from decoder: Decoder) throws {
        let values      = try decoder.container(keyedBy: CodingKeys.self)
        self.dt         = try values.decodeIfPresent(Double.self, forKey: .dt) ?? 0
        self.sunrise    = try values.decodeIfPresent(Double.self, forKey: .sunrise) ?? 0
        self.sunset     = try values.decodeIfPresent(Double.self, forKey: .sunset) ?? 0
        self.temp       = try values.decodeIfPresent(Temp.self, forKey: .temp) ?? Temp()
        self.feelsLike  = try values.decodeIfPresent(FeelsLike.self, forKey: .feelsLike) ?? FeelsLike()
        self.pressure   = try values.decodeIfPresent(Double.self, forKey: .pressure) ?? 0
        self.humidity   = try values.decodeIfPresent(Double.self, forKey: .humidity) ?? 0
        self.dewPoint   = try values.decodeIfPresent(Double.self, forKey: .dewPoint) ?? 0
        self.uvi        = try values.decodeIfPresent(Double.self, forKey: .uvi) ?? 0
        self.clouds     = try values.decodeIfPresent(Double.self, forKey: .clouds) ?? 0
        self.windSpeed  = try values.decodeIfPresent(Double.self, forKey: .windSpeed) ?? 0
        self.windDeg    = try values.decodeIfPresent(Double.self, forKey: .windDeg) ?? 0
        self.windGust   = try values.decodeIfPresent(Double.self, forKey: .windGust) ?? 0
        self.weather    = try values.decodeIfPresent([Weather].self, forKey: .weather) ?? []
    }
    
    init() {
        self.dt = 0
        self.sunrise = 0
        self.sunset = 0
        self.temp = Temp()
        self.feelsLike = FeelsLike()
        self.pressure = 0
        self.humidity = 0
        self.dewPoint = 0
        self.uvi = 0
        self.clouds = 0
        self.windSpeed = 0
        self.windDeg = 0
        self.windGust = 0
        self.weather = []
    }
}

// MARK: - FeelsLike
struct FeelsLike: Codable {
    var day, night, eve, morn: Double?
    
    enum CodingKeys: String, CodingKey {
        case day, night, eve, morn
    }
    
    init(from decoder: Decoder) throws {
        let values      = try decoder.container(keyedBy: CodingKeys.self)
        self.day   = try values.decodeIfPresent(Double.self, forKey: .day) ?? 0
        self.night   = try values.decodeIfPresent(Double.self, forKey: .night) ?? 0
        self.eve   = try values.decodeIfPresent(Double.self, forKey: .eve) ?? 0
        self.morn   = try values.decodeIfPresent(Double.self, forKey: .morn) ?? 0
    }
    
    init() {
        self.day = 0
        self.night = 0
        self.eve = 0
        self.morn = 0
    }
}

// MARK: - Temp
struct Temp: Codable {
    var day, min, max, night: Double?
    var eve, morn: Double?
    
    enum CodingKeys: String, CodingKey {
        case day, min, max, night, eve, morn
    }
    
    init(from decoder: Decoder) throws {
        let values      = try decoder.container(keyedBy: CodingKeys.self)
        self.day   = try values.decodeIfPresent(Double.self, forKey: .day) ?? 0
        self.min   = try values.decodeIfPresent(Double.self, forKey: .min) ?? 0
        self.max   = try values.decodeIfPresent(Double.self, forKey: .max) ?? 0
        self.night   = try values.decodeIfPresent(Double.self, forKey: .night) ?? 0
        self.eve   = try values.decodeIfPresent(Double.self, forKey: .eve) ?? 0
        self.morn   = try values.decodeIfPresent(Double.self, forKey: .morn) ?? 0
    }
    
    init() {
        self.day = 0
        self.min = 0
        self.max = 0
        self.night = 0
        self.eve = 0
        self.morn = 0
    }
}
