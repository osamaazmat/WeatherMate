//
//  HomeViewController.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 27/05/2022.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var windPressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var minMaxTempLabel: UILabel!
    
    var currentLocation : CLLocationCoordinate2D!
    
    // MARK: ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: Setup Methods
extension HomeViewController {
    private func setupUI() {
        setupNotificationObservers()
        setupLocation()
    }
    
    private func setupLocation() {
        let LocationMgr = LocationManager.instance
        LocationMgr.delegate = self
    }
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(locationUpdateNotification(_:)), name: NSNotification.Name(rawValue: NotificationNames.kLocationDidChangeNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateWeather(_:)), name: NSNotification.Name(rawValue: NotificationNames.weatherDidUpdateNotification), object: nil)
    }
    
    private func setupData(with weatherModel: WeatherModel) {
        
        cityLabel.text = weatherModel.name
        
        if let temp = weatherModel.mainData?.temp {
            currentTempLabel.text = "\(temp)°"
        } else {
            currentTempLabel.text = "--"
        }
        
        if let minTemp = weatherModel.mainData?.tempMin, let maxTemp = weatherModel.mainData?.tempMax {
            minMaxTempLabel.text = "\(minTemp)°, \(maxTemp)°"
        } else {
            minMaxTempLabel.text = "--, --"
        }
        
        if let weatherData = weatherModel.weatherData, weatherData.count > 0 {
            WeatherManager.instance.setWeatherType(with: weatherData[0].id ?? 0)
            weatherDescriptionLabel.text = "\(weatherData[0].weatherDescription ?? "--")".capitalized
        } else {
            weatherDescriptionLabel.text = "--"
        }
        
        if let windSpeed = weatherModel.wind?.speed {
            windSpeedLabel.text = "\(windSpeed)"
        } else {
            windSpeedLabel.text = "--"
        }
        
        if let windDirection = weatherModel.wind?.deg {
            windDirectionLabel.text = "\(windDirection)"
        } else {
            windDirectionLabel.text = "--"
        }
     
        if let pressure = weatherModel.mainData?.pressure {
            windPressureLabel.text = "\(pressure)"
        } else {
            windPressureLabel.text = "--"
        }
        
        if let humidity = weatherModel.mainData?.humidity {
            humidityLabel.text = "\(humidity)"
        } else {
            humidityLabel.text = "--"
        }
        
       
    }
}

// MARK: Api Calls
extension HomeViewController {
    private func getWeatherData() {
        LoaderManager.instance.show()
       
        NetworkService.default.execute(WeatherAPIs.getWeatherData(lat: currentLocation.latitude.description, lon: currentLocation.longitude.description, exclude: "hourly,daily"), model: WeatherModel.self) { [weak self] result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                LoaderManager.instance.hide()
            }
            
            guard let self = self else {
                return
            }

            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.setupData(with: response)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension HomeViewController {
    
    // MARK: Weather
    @objc func updateWeather(_ notification: Notification) {
        mainImageView.image = WeatherManager.instance.weatherType.getBackgroundImage()
    }
}

// MARK: Location
extension HomeViewController: LocationUpdateProtocol {
    
    // MARK: Notifications
    @objc func locationUpdateNotification(_ notification: Notification) {
        let userinfo = notification.userInfo
        self.currentLocation = userinfo!["location"] as? CLLocationCoordinate2D
        print("Latitude : \(self.currentLocation.latitude)")
        print("Longitude : \(self.currentLocation.longitude)")

    }

    // MARK: LocationUpdateProtocol
    func locationDidUpdateToLocation(_ location: CLLocationCoordinate2D) {
        currentLocation = location
        print("Latitude : \(self.currentLocation.latitude)")
        print("Longitude : \(self.currentLocation.longitude)")
        
        getWeatherData()
    }
}
