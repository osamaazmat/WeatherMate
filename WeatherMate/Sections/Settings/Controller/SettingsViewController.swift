//
//  SettingsViewController.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 27/05/2022.
//

import UIKit
import CoreLocation

class SettingsViewController: UIViewController {

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
        tableView.register(UINib(nibName: ProfileSettingsTableViewCell.cellNibName, bundle: nil), forCellReuseIdentifier: ProfileSettingsTableViewCell.cellReuseIdentifier)
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return ""
        } else {
            return "Account"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileSettingsTableViewCell.cellReuseIdentifier, for: indexPath) as? ProfileSettingsTableViewCell else {
                return UITableViewCell()
            }
            
            let user = CacheManager.instance.getUserData()
            if let user = user {
                cell.nameLabel.text = user.email
            } else {
                cell.nameLabel.text = "Hi, Guest!"
            }
           
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.cellReuseIdentifier, for: indexPath) as? SettingsTableViewCell else {
                return UITableViewCell()
            }
            
            if LoginManager.instance.isUserLoggedIn() {
                cell.mainLabel.text = "Logout"
            } else {
                cell.mainLabel.text = "Login"
            }
          
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if LoginManager.instance.isUserLoggedIn() {
                LoginManager.instance.logOut()
                self.tableView.reloadData()
            } else {
                let tabBar = LoginViewController()
                UIApplication.shared.mainKeyWindow?.rootViewController = tabBar
                UIApplication.shared.mainKeyWindow?.makeKeyAndVisible()
            }
        }
    }
}
