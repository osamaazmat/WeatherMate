//
//  WeeklyForecastViewModel.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 30/05/2022.
//

import Foundation
import CoreLocation

class WeeklyForecastViewModel: WeeklyForecastViewModelProtocol {
    var forecastModel: ForecastModel? {
        didSet {
            self.forecastDidChange?(self)
        }
    }
    
    var forecastDidChange: ((WeeklyForecastViewModelProtocol) -> ())?
    
    func getWeeklyWeatherData(with currentLocation: CLLocationCoordinate2D) {
        
        NetworkService.default.execute(WeatherAPIs.getForecastData(lat: currentLocation.latitude.description, lon: currentLocation.longitude.description, exclude: "hourly,minutely"), model: ForecastModel.self) { [weak self] result in
            
            guard let strongSelf = self else {
                return
            }

            switch result {
            case .success(let response):
                strongSelf.forecastModel = response
            case .failure(let error):
                print(error)
            }
        }
    }
}
