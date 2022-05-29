//
//  HomeViewModel.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 30/05/2022.
//

import Foundation
import CoreLocation

class HomeViewModel: HomeViewModelProtocol {
    
    var weatherModel: WeatherModel? {
        didSet {
            self.weatherDidChange?(self)
        }
    }
    var weatherDidChange: ((HomeViewModelProtocol) -> ())?
    
    func getWeatherData(with currentLocation: CLLocationCoordinate2D) {
        NetworkService.default.execute(WeatherAPIs.getWeatherData(lat: currentLocation.latitude.description, lon: currentLocation.longitude.description, exclude: "hourly,daily"), model: WeatherModel.self) { [weak self] result in
            
            guard let strongSelf = self else {
                return
            }

            switch result {
            case .success(let response):
                strongSelf.weatherModel = response
            case .failure(let error):
                print(error)
            }
        }
    }
}
