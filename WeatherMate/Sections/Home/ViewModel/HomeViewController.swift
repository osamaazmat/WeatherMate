//
//  HomeViewController.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 27/05/2022.
//

import UIKit

class HomeViewController: BaseViewController {

    // MARK: IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var windPressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var minMaxTempLabel: UILabel!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    var weatherDataRecieved: Bool = false
    
    // MARK: ViewModel
    var viewModel: HomeViewModelProtocol! {
        didSet {
            viewModel.weatherDidChange = { [unowned self] viewModel in
                DispatchQueue.main.async {
                    if let weatherModel = viewModel.weatherModel {
                        self.setupData(with: weatherModel)
                    }
                    self.weatherDataRecieved = true
                    self.scrollView.refreshControl?.endRefreshing()
                    LoaderManager.instance.hide()
                }
            }
        }
    }
    
    // MARK: ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func configureRefreshControl() {
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        scrollView.delegate = self
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            topConstraint.constant = -scrollView.contentOffset.y/2
        } else {
            topConstraint.constant = 0
        }
    }
}

// MARK: Setup Methods
extension HomeViewController {
    private func setupUI() {
        setupNotificationObservers()
        configureRefreshControl()
        getWeatherData()
    }
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(locationUpdated(_:)), name: NSNotification.Name(rawValue: NotificationNames.kLocationDidChangeNotification), object: nil)
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
    private func getWeatherData(_ isFromRefreshControl: Bool = false) {
        
        if currentLocation == nil {
            LocationManager.instance.refreshLocation()
            return
        }
        
        if !isFromRefreshControl {
            LoaderManager.instance.show()
        }
        
        self.viewModel.getWeatherData(with: currentLocation)
    }
}

extension HomeViewController {
    
    // MARK: Weather
    @objc func updateWeather(_ notification: Notification) {
        mainImageView.image = WeatherManager.instance.weatherType.getBackgroundImage()
    }
}

// MARK: Action Methods
extension HomeViewController {
    
    // MARK: Notifications
    @objc func locationUpdated(_ notification: Notification) {
        if !weatherDataRecieved {
            getWeatherData()
        }
    }
    
    @objc func handleRefreshControl() {
        self.getWeatherData(true)
    }
}
