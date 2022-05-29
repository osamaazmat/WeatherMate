//
//  WeeklyForecastTableViewCell.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 27/05/2022.
//

import UIKit
import AlamofireImage

class WeeklyForecastTableViewCell: UITableViewCell {

    static let cellNibName = "WeeklyForecastTableViewCell"
    static let cellReuseIdentifier = "weeklyForecastTableViewCell"
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherDescLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension WeeklyForecastTableViewCell {
    
    func configureCell(with dailyWeatherObject: Daily) {
        
        speedLabel.text         = "\(dailyWeatherObject.windSpeed ?? 0)"
        directionLabel.text     = "\(dailyWeatherObject.windDeg ?? 0)"
        pressureLabel.text      = "\(dailyWeatherObject.pressure ?? 0)"
        if let weather = dailyWeatherObject.weather, weather.count > 0 {
            weatherDescLabel.text   = "\(weather[0].weatherDescription ?? "--")".capitalized
            let urlBuild = "http://openweathermap.org/img/wn/\(weather[0].icon ?? "10d")@2x.png"
            if let url = URL(string: urlBuild) {
                weatherImageView.af.setImage(withURL: url)
            }
        }
        
        if let min = dailyWeatherObject.temp?.min, let max = dailyWeatherObject.temp?.max {
            let averageTemperature =  Int((min + max) / 2)
            temperatureLabel.text   = "\(averageTemperature)°"
        }
        
        if let timeResult = dailyWeatherObject.dt {
            let date = Date(timeIntervalSince1970: TimeInterval(timeResult))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
            dateFormatter.timeZone = .current
            let localDate = dateFormatter.string(from: date)
            dateLabel.text = "\(localDate)"
        }
    }
}
