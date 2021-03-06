//
//  TabBar.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 27/05/2022.
//

import Foundation
import UIKit

class TabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupVCs()
    }
    
    private func setupAppearance() {
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().clipsToBounds = true
    }
    
    private func setupVCs() {
        viewControllers = [
            createNavController(for: ViewControllerFactory.makeHome(), title: "Home", image: UIImage(systemName: "house")!),
            createNavController(for: ViewControllerFactory.makeWeeklyForecast(), title: "Weekly", image: UIImage(systemName: "calendar")!),
            createNavController(for: ViewControllerFactory.makeSettings(), title: "Settings", image: UIImage(systemName: "gear")!)
        ]
    }
    
    private func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.isHidden = true
        navController.setNavigationBarHidden(true, animated: false)
        rootViewController.navigationItem.title = ""
        return navController
    }
}
