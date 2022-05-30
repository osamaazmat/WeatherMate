//
//  WeeklyForecastContract.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 30/05/2022.
//

import Foundation
import CoreLocation

protocol WeeklyForecastViewModelProtocol: BaseViewModelProtocol {
    var forecastModel: ForecastModel? { get }
    var forecastDidChange: ((WeeklyForecastViewModelProtocol) -> ())? { get set }
    func getWeeklyWeatherData(with currentLocation: CLLocationCoordinate2D)
}
