//
//  LoaderManager.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 28/05/2022.
//

import Foundation
import UIKit
import Lottie

class LoaderManager {
    
    // MARK: Properties
    var alertVC: UIViewController!
    var animation: Animation!
    var animationView: AnimationView!
    static let instance = LoaderManager()
    private init() {
        setupLottieAnimation()
    }
    
    // MARK: Setup Functions
    private func setupLottieAnimation() {
        let jsonName = "weather_lottie"
        animation = Animation.named(jsonName)
        animationView = AnimationView(animation: animation)
        animationView.loopMode = .loop
        animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
    }
    
    // MARK: Show and Hide Methods
    func show() {
        self.hide()
        
        if alertVC == nil {
            alertVC = UIViewController()
        }
        
        if animationView == nil {
            setupLottieAnimation()
        }

        alertVC.view.addSubview(animationView)
        animationView.center = alertVC.view.center
        alertVC.view.bringSubviewToFront(animationView)
        animationView.play()
        
        alertVC.view.backgroundColor    = UIColor.black.withAlphaComponent(0.5)
        alertVC.modalPresentationStyle  = .overCurrentContext
        alertVC.modalTransitionStyle    = .crossDissolve
        
        let topVC = UIApplication.shared.topMostViewController()
        topVC?.present(alertVC, animated: true, completion: nil)
    }
     
    func hide() {
        if let alertVC = alertVC {
            for subview in alertVC.view.subviews {
                subview.removeFromSuperview()
            }
            alertVC.dismiss(animated: true, completion: nil)
            self.alertVC = nil
        }
    }
}
