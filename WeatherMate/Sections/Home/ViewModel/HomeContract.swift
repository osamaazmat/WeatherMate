//
//  HomeContract.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 30/05/2022.
//

import Foundation
import CoreLocation

protocol HomeViewModelProtocol: BaseViewModelProtocol {
    var weatherModel: WeatherModel? { get }
    var weatherDidChange: ((HomeViewModelProtocol) -> ())? { get set }
    func getWeatherData(with currentLocation: CLLocationCoordinate2D)
}
