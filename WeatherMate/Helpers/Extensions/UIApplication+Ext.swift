//
//  UIApplication+Ext.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 28/05/2022.
//

import Foundation
import UIKit

// MARK: UIViewController Extension
extension UIViewController {

    // MARK: TopViewController Function
    func topMostViewController() -> UIViewController {
        if self.presentedViewController == nil {
            return self
        }

        if let navigation = self.presentedViewController as? UINavigationController {
            return navigation.visibleViewController!.topMostViewController()
        }

        if let tab = self.presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }

        return self.presentedViewController!.topMostViewController()
    }
}

// MARK: UIApplication Extension
extension UIApplication {
    func topMostViewController() -> UIViewController? {
        let vc = UIApplication.shared.mainKeyWindow?.rootViewController?.topMostViewController()
        return vc
    }
    
    var mainKeyWindow: UIWindow? {
          get {
              if #available(iOS 13, *) {
                  return connectedScenes
                      .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                      .first { $0.isKeyWindow }
              } else {
                  return keyWindow
              }
          }
      }
}
