//
//  BaseViewController.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 29/05/2022.
//

import UIKit
import CoreLocation
import NotificationBannerSwift

class BaseViewController: UIViewController {

    var currentLocation : CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotificationObservers()
        setupLocation()
    }
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(locationUpdateNotification(_:)), name: NSNotification.Name(rawValue: NotificationNames.kLocationDidChangeNotification), object: nil)
    }
    
    private func setupLocation() {
        let LocationMgr = LocationManager.instance
        LocationMgr.delegate = self
    }
}

// MARK: Action Methods
extension BaseViewController: LocationUpdateProtocol {
    
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
    }
}
