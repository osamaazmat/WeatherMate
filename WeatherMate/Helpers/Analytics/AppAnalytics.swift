//
//  AppAnalytics.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 31/05/2022.
//

import Foundation
import FirebaseAnalytics

protocol AppAnalyticsProtocol: AnyObject {
    static func logEvent(withName name: String)
}

class AppAnalytics: AppAnalyticsProtocol {
    
    static func logEvent(withName name: String) {
        Analytics.logEvent(name, parameters: [
          "name": name as NSObject
        ])
    }
}
