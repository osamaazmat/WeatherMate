//
//  AppRouter.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 30/05/2022.
//

import Foundation
import UIKit

protocol AppRouterProtocol: AnyObject {
    static func moveToLogin(withNavigationController navigationController: UINavigationController?)
    static func moveToLogin(withWindow window: UIWindow?, andWinowScene windowScene: UIWindowScene)
    static func moveToTabBar(withNavigationController navigationController: UINavigationController?)
}

class AppRouter: AppRouterProtocol {
    static func moveToLogin(withWindow window: UIWindow?, andWinowScene windowScene: UIWindowScene) {
        if let window = window {
            let loginVC = ViewControllerFactory.makeLogin()
            window.rootViewController = loginVC
            window.windowScene = windowScene
        } else {
            let vc = ViewControllerFactory.makeLogin()
            UIApplication.shared.mainKeyWindow?.rootViewController = vc
            UIApplication.shared.mainKeyWindow?.makeKeyAndVisible()
        }
    }
    
    static func moveToLogin(withNavigationController navigationController: UINavigationController?) {
        if let navigationController = navigationController {
            let loginVC = ViewControllerFactory.makeLogin()
            navigationController.pushViewController(loginVC, animated: true)
        } else {
            let vc = ViewControllerFactory.makeLogin()
            UIApplication.shared.mainKeyWindow?.rootViewController = vc
            UIApplication.shared.mainKeyWindow?.makeKeyAndVisible()
        }
    }
    
    static func moveToTabBar(withNavigationController navigationController: UINavigationController?) {
        if let navigationController = navigationController {
            let tabBarVC = ViewControllerFactory.makeTabBar()
            navigationController.pushViewController(tabBarVC, animated: true)
        } else {
            let tabBar = ViewControllerFactory.makeTabBar()
            UIApplication.shared.mainKeyWindow?.rootViewController = tabBar
            UIApplication.shared.mainKeyWindow?.makeKeyAndVisible()
        }
    }
}
