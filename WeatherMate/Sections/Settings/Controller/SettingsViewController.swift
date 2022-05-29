//
//  SettingsViewController.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 27/05/2022.
//

import UIKit
import CoreLocation

class SettingsViewController: UIViewController {

    let settingsArray1 = ["Name", "Location"]
    let settingsArray2 = ["Logout"]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mainImageView: UIImageView!
    
    var currentLocation : CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotificationObservers()
        registerCells()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupBackgroundImage()
    }
}

extension SettingsViewController {
    
    private func setupBackgroundImage() {
        mainImageView.image = WeatherManager.instance.weatherType.getBackgroundImage()
    }
    
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateWeather(_:)), name: NSNotification.Name(rawValue: NotificationNames.weatherDidUpdateNotification), object: nil)
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: SettingsTableViewCell.cellNibName, bundle: nil), forCellReuseIdentifier: SettingsTableViewCell.cellReuseIdentifier)
    }
}

extension SettingsViewController {
    
    // MARK: Weather
    @objc func updateWeather(_ notification: Notification) {
        mainImageView.image = WeatherManager.instance.weatherType.getBackgroundImage()
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return settingsArray1.count
        } else {
            return settingsArray2.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "General"
        } else {
            return "Account"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.cellReuseIdentifier, for: indexPath) as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        
        let arrayOfSettings = indexPath.section == 0 ? settingsArray1 : settingsArray2
        cell.mainLabel.text = arrayOfSettings[indexPath.item]
        
        return cell
    }
}
