//
//  WeeklyForecastViewController.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 27/05/2022.
//

import UIKit
import CoreLocation

class WeeklyForecastViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mainImageView: UIImageView!
    
    var currentLocation : CLLocationCoordinate2D!
    var forecastModel: ForecastModel!
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotificationObservers()
        registerCells()
        
        if LocationManager.instance.currentLocation != nil {
            currentLocation = LocationManager.instance.currentLocation
            getWeeklyWeatherData()
        } else {
            setupLocation()
        }
    }
}

// MARK: Private Methods
extension WeeklyForecastViewController {
    
    private func setupBackgroundImage() {
        mainImageView.image = WeatherManager.instance.weatherType.getBackgroundImage()
    }
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateWeather(_:)), name: NSNotification.Name(rawValue: NotificationNames.weatherDidUpdateNotification), object: nil)
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: WeeklyForecastTableViewCell.cellNibName, bundle: nil), forCellReuseIdentifier: WeeklyForecastTableViewCell.cellReuseIdentifier)
    }
    
    private func setupLocation() {
        if LocationManager.instance.currentLocation == nil {
            let LocationMgr = LocationManager.instance
            LocationMgr.delegate = self
        }
    }
}

// MARK: API Calls
extension WeeklyForecastViewController {
    
    // MARK: Get Weekly Weather Data
    private func getWeeklyWeatherData() {
        LoaderManager.instance.show()
        
        NetworkService.default.execute(WeatherAPIs.getForecastData(lat: currentLocation.latitude.description, lon: currentLocation.longitude.description, exclude: "hourly,minutely"), model: ForecastModel.self) { [weak self] result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                LoaderManager.instance.hide()
            }
            
            guard let self = self else {
                return
            }

            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.forecastModel = response
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}


// MARK: Observers
extension WeeklyForecastViewController {
    
    // MARK: Weather
    @objc func updateWeather(_ notification: Notification) {
        mainImageView.image = WeatherManager.instance.weatherType.getBackgroundImage()
    }
}

// MARK: TableView Delegate & DataSource
extension WeeklyForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let forecastModel = forecastModel {
            return forecastModel.daily?.count ?? 0
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeeklyForecastTableViewCell.cellReuseIdentifier, for: indexPath) as? WeeklyForecastTableViewCell else {
            return UITableViewCell()
        }
        if let daily = forecastModel.daily {
            cell.configureCell(with: daily[indexPath.item])
        }
        
        return cell
    }
}

// MARK: Location
extension WeeklyForecastViewController: LocationUpdateProtocol {
    
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
        
        getWeeklyWeatherData()
    }
}
