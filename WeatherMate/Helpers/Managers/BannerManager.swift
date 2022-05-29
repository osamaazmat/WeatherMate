//
//  BannerManager.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 30/05/2022.
//

import Foundation
import NotificationBannerSwift

class BannerManager {
    
    static let instance = BannerManager()
    private init() {}
 
    func showBanner(title: String, message: String) {
        DispatchQueue.main.async {
            let banner = FloatingNotificationBanner(title: title, subtitle: message, style: .info)
            banner.show()
        }
    }
}
