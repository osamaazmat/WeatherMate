//
//  ModelMocks.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 30/05/2022.
//

import Foundation

enum ModelMocks {
    static let weatherModelFailure = ""
    static let forecastModelFailure = ""
    static let weatherModel =
    """
            {
                "coord": {
                    "lon": 73.0845,
                    "lat": 33.738
                },
                "weather": [{
                    "id": 803,
                    "main": "Clouds",
                    "description": "broken clouds",
                    "icon": "04d"
                }],
                "base": "stations",
                "main": {
                    "temp": 32.76,
                    "feels_like": 31.57,
                    "temp_min": 32.76,
                    "temp_max": 32.76,
                    "pressure": 1001,
                    "humidity": 29,
                    "sea_level": 1001,
                    "grnd_level": 937
                },
                "visibility": 10000,
                "wind": {
                    "speed": 2.36,
                    "deg": 194,
                    "gust": 2.39
                },
                "clouds": {
                    "all": 81
                },
                "dt": 1653890388,
                "sys": {
                    "type": 2,
                    "id": 2007435,
                    "country": "PK",
                    "sunrise": 1653868746,
                    "sunset": 1653919893
                },
                "timezone": 18000,
                "id": 1176615,
                "name": "Islamabad",
                "cod": 200
            }
    """
    static let forecastModel =
    """
            {
                "lat": 33.738,
                "lon": 73.0845,
                "timezone": "Asia/Karachi",
                "timezone_offset": 18000,
                "current": {
                    "dt": 1653890529,
                    "sunrise": 1653868746,
                    "sunset": 1653919893,
                    "temp": 32.76,
                    "feels_like": 31.57,
                    "pressure": 1001,
                    "humidity": 29,
                    "dew_point": 12.4,
                    "uvi": 10.07,
                    "clouds": 78,
                    "visibility": 10000,
                    "wind_speed": 2.28,
                    "wind_deg": 288,
                    "wind_gust": 2.45,
                    "weather": [{
                        "id": 803,
                        "main": "Clouds",
                        "description": "broken clouds",
                        "icon": "04d"
                    }]
                },
                "daily": [{
                    "dt": 1653894000,
                    "sunrise": 1653868746,
                    "sunset": 1653919893,
                    "moonrise": 1653867600,
                    "moonset": 1653920220,
                    "moon_phase": 0,
                    "temp": {
                        "day": 33.45,
                        "min": 25.38,
                        "max": 38.68,
                        "night": 29.66,
                        "eve": 37.14,
                        "morn": 26.38
                    },
                    "feels_like": {
                        "day": 32,
                        "night": 28.03,
                        "eve": 34.44,
                        "morn": 26.38
                    },
                    "pressure": 1001,
                    "humidity": 26,
                    "dew_point": 11.34,
                    "wind_speed": 5.99,
                    "wind_deg": 283,
                    "wind_gust": 10.7,
                    "weather": [{
                        "id": 803,
                        "main": "Clouds",
                        "description": "broken clouds",
                        "icon": "04d"
                    }],
                    "clouds": 82,
                    "pop": 0.05,
                    "uvi": 11.28
                }, {
                    "dt": 1653980400,
                    "sunrise": 1653955126,
                    "sunset": 1654006331,
                    "moonrise": 1653956340,
                    "moonset": 1654010040,
                    "moon_phase": 0.03,
                    "temp": {
                        "day": 38.78,
                        "min": 26.86,
                        "max": 39.84,
                        "night": 29.01,
                        "eve": 35.25,
                        "morn": 28.09
                    },
                    "feels_like": {
                        "day": 36.09,
                        "night": 27.68,
                        "eve": 32.9,
                        "morn": 27.07
                    },
                    "pressure": 999,
                    "humidity": 12,
                    "dew_point": 3.53,
                    "wind_speed": 7.21,
                    "wind_deg": 42,
                    "wind_gust": 10.36,
                    "weather": [{
                        "id": 500,
                        "main": "Rain",
                        "description": "light rain",
                        "icon": "10d"
                    }],
                    "clouds": 21,
                    "pop": 0.32,
                    "rain": 0.22,
                    "uvi": 10.35
                }, {
                    "dt": 1654066800,
                    "sunrise": 1654041507,
                    "sunset": 1654092767,
                    "moonrise": 1654045320,
                    "moonset": 1654099680,
                    "moon_phase": 0.06,
                    "temp": {
                        "day": 39.87,
                        "min": 25.88,
                        "max": 39.87,
                        "night": 29.2,
                        "eve": 35.1,
                        "morn": 27.27
                    },
                    "feels_like": {
                        "day": 37.04,
                        "night": 27.78,
                        "eve": 32.84,
                        "morn": 26.76
                    },
                    "pressure": 999,
                    "humidity": 11,
                    "dew_point": 3.07,
                    "wind_speed": 7.24,
                    "wind_deg": 34,
                    "wind_gust": 8.15,
                    "weather": [{
                        "id": 500,
                        "main": "Rain",
                        "description": "light rain",
                        "icon": "10d"
                    }],
                    "clouds": 2,
                    "pop": 0.6,
                    "rain": 0.75,
                    "uvi": 8.84
                }, {
                    "dt": 1654153200,
                    "sunrise": 1654127889,
                    "sunset": 1654179203,
                    "moonrise": 1654134660,
                    "moonset": 1654189080,
                    "moon_phase": 0.09,
                    "temp": {
                        "day": 39.48,
                        "min": 26.48,
                        "max": 40.93,
                        "night": 31.88,
                        "eve": 39.86,
                        "morn": 26.52
                    },
                    "feels_like": {
                        "day": 36.34,
                        "night": 29.71,
                        "eve": 36.42,
                        "morn": 26.52
                    },
                    "pressure": 1000,
                    "humidity": 9,
                    "dew_point": 0.15,
                    "wind_speed": 6.04,
                    "wind_deg": 257,
                    "wind_gust": 7.17,
                    "weather": [{
                        "id": 804,
                        "main": "Clouds",
                        "description": "overcast clouds",
                        "icon": "04d"
                    }],
                    "clouds": 91,
                    "pop": 0,
                    "uvi": 11.07
                }, {
                    "dt": 1654239600,
                    "sunrise": 1654214274,
                    "sunset": 1654265637,
                    "moonrise": 1654224300,
                    "moonset": 1654278120,
                    "moon_phase": 0.12,
                    "temp": {
                        "day": 40.07,
                        "min": 27.26,
                        "max": 41.4,
                        "night": 31.36,
                        "eve": 40.47,
                        "morn": 27.26
                    },
                    "feels_like": {
                        "day": 36.89,
                        "night": 29.25,
                        "eve": 36.95,
                        "morn": 26.34
                    },
                    "pressure": 999,
                    "humidity": 9,
                    "dew_point": 0.64,
                    "wind_speed": 6.38,
                    "wind_deg": 287,
                    "wind_gust": 4.75,
                    "weather": [{
                        "id": 800,
                        "main": "Clear",
                        "description": "clear sky",
                        "icon": "01d"
                    }],
                    "clouds": 4,
                    "pop": 0,
                    "uvi": 10.94
                }, {
                    "dt": 1654326000,
                    "sunrise": 1654300659,
                    "sunset": 1654352071,
                    "moonrise": 1654314060,
                    "moonset": 1654366860,
                    "moon_phase": 0.15,
                    "temp": {
                        "day": 40.59,
                        "min": 28.55,
                        "max": 42.58,
                        "night": 33.24,
                        "eve": 41.73,
                        "morn": 28.55
                    },
                    "feels_like": {
                        "day": 37.21,
                        "night": 30.81,
                        "eve": 37.86,
                        "morn": 27.11
                    },
                    "pressure": 999,
                    "humidity": 8,
                    "dew_point": -0.51,
                    "wind_speed": 5.69,
                    "wind_deg": 253,
                    "wind_gust": 4.17,
                    "weather": [{
                        "id": 800,
                        "main": "Clear",
                        "description": "clear sky",
                        "icon": "01d"
                    }],
                    "clouds": 1,
                    "pop": 0,
                    "uvi": 11
                }, {
                    "dt": 1654412400,
                    "sunrise": 1654387047,
                    "sunset": 1654438504,
                    "moonrise": 1654404000,
                    "moonset": 1654455300,
                    "moon_phase": 0.18,
                    "temp": {
                        "day": 41.94,
                        "min": 29.19,
                        "max": 44.05,
                        "night": 34.13,
                        "eve": 43.05,
                        "morn": 29.19
                    },
                    "feels_like": {
                        "day": 38.23,
                        "night": 31.56,
                        "eve": 38.72,
                        "morn": 27.53
                    },
                    "pressure": 999,
                    "humidity": 7,
                    "dew_point": -1.87,
                    "wind_speed": 5.17,
                    "wind_deg": 232,
                    "wind_gust": 3.81,
                    "weather": [{
                        "id": 800,
                        "main": "Clear",
                        "description": "clear sky",
                        "icon": "01d"
                    }],
                    "clouds": 0,
                    "pop": 0,
                    "uvi": 11
                }, {
                    "dt": 1654498800,
                    "sunrise": 1654473435,
                    "sunset": 1654524936,
                    "moonrise": 1654493940,
                    "moonset": 0,
                    "moon_phase": 0.21,
                    "temp": {
                        "day": 42.34,
                        "min": 29.81,
                        "max": 44.6,
                        "night": 34.74,
                        "eve": 43.73,
                        "morn": 29.81
                    },
                    "feels_like": {
                        "day": 38.58,
                        "night": 32.09,
                        "eve": 39.25,
                        "morn": 28
                    },
                    "pressure": 998,
                    "humidity": 7,
                    "dew_point": -0.79,
                    "wind_speed": 6.11,
                    "wind_deg": 264,
                    "wind_gust": 5.06,
                    "weather": [{
                        "id": 800,
                        "main": "Clear",
                        "description": "clear sky",
                        "icon": "01d"
                    }],
                    "clouds": 0,
                    "pop": 0,
                    "uvi": 11
                }]
            }
    """
}
