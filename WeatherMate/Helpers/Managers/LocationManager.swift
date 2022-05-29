//
//  LocationManager.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 28/05/2022.
//
import MapKit
import CoreLocation

protocol LocationUpdateProtocol {
    func locationDidUpdateToLocation(_ location : CLLocationCoordinate2D)
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    // MARK: Properties
    static let instance = LocationManager()
    fileprivate var locationManager = CLLocationManager()
    var currentLocation : CLLocationCoordinate2D?
    var delegate : LocationUpdateProtocol!
    
    // MARK: LifeCycle
    fileprivate override init () {
        super.init()
        self.locationManager.delegate = self
        refreshLocation()
    }
    
    // MARK: Delegate Functions
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = (manager.location?.coordinate)!
        let userInfo : NSDictionary = ["location" : currentLocation!]
        
        DispatchQueue.main.async {
            self.delegate?.locationDidUpdateToLocation(self.currentLocation!)
            NotificationCenter.default.post(name: Notification.Name(NotificationNames.kLocationDidChangeNotification), object: self, userInfo: userInfo as [NSObject : AnyObject])
        }
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    // MARK: Private Methods
    func refreshLocation() {
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        self.locationManager.requestLocation()
    }
}

