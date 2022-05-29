//
//  WeeklyForecastViewController.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 27/05/2022.
//

import UIKit
import CoreLocation

class WeeklyForecastViewController: BaseViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mainImageView: UIImageView!
    
    var weatherDataRecieved: Bool = false
    var forecastModel: ForecastModel!
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotificationObservers()
        registerCells()
        configureRefreshControl()
        getWeeklyWeatherData()
    }
    
    func configureRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
}

// MARK: Private Methods
extension WeeklyForecastViewController {
    
    private func setupBackgroundImage() {
        mainImageView.image = WeatherManager.instance.weatherType.getBackgroundImage()
    }
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(locationUpdated(_:)), name: NSNotification.Name(rawValue: NotificationNames.kLocationDidChangeNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateWeather(_:)), name: NSNotification.Name(rawValue: NotificationNames.weatherDidUpdateNotification), object: nil)
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: WeeklyForecastTableViewCell.cellNibName, bundle: nil), forCellReuseIdentifier: WeeklyForecastTableViewCell.cellReuseIdentifier)
    }
}

// MARK: API Calls
extension WeeklyForecastViewController {
    
    // MARK: Get Weekly Weather Data
    private func getWeeklyWeatherData(_ isFromRefreshControl: Bool = false) {
        
        if currentLocation == nil {
            LocationManager.instance.refreshLocation()
            return
        }
        
        if !isFromRefreshControl {
            LoaderManager.instance.show()
        }
        
        NetworkService.default.execute(WeatherAPIs.getForecastData(lat: currentLocation.latitude.description, lon: currentLocation.longitude.description, exclude: "hourly,minutely"), model: ForecastModel.self) { [weak self] result in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                LoaderManager.instance.hide()
                self?.tableView.refreshControl?.endRefreshing()
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

// MARK: Action Methods
extension WeeklyForecastViewController {

    @objc func locationUpdated(_ notification: Notification) {
        if !weatherDataRecieved {
            getWeeklyWeatherData()
        }
    }
    
    @objc func handleRefreshControl() {
        self.getWeeklyWeatherData(true)
    }
}
