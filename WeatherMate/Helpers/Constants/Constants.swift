//
//  Constants.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 27/05/2022.
//

import Foundation

enum AppKeys {
    static let API_Key = "f4487ac6d0c12d1e935291706da2f64f"
}

enum Path {
    enum Weather {
        public static let getWeatherData = "data/2.5/weather"
        public static let getForecastData = "data/2.5/onecall"
    }
}

enum NotificationNames {
    static let kLocationDidChangeNotification = "LocationDidChangeNotification"
    static let weatherDidUpdateNotification = "WeatherDidUpdateNotification"
}

enum AppStrings {
    enum Login {
        static let loginButtonText = "Login"
        static let signUpButtonText = "Sign Up"
        static let alreadyHaveAnAccount = "Already have an account? Login!"
        static let dontHaveAnAccount = "Dont have an account? Signup!"
    }
    
    enum Settings {
        static let account = "Account"
        static let login = "Login"
        static let logout = "Logout"
        static let guestMessage = "Hi, Guest!"
    }
    
    enum Banner {
        enum Title {
            static let error = "Error"
            static let invalidData = "Invalid Data"
        }
        
        enum Body {
            static let invalidData = "Please enter information in correct format"
            static let internetNotConnected = "Internet Not Connected"
        }
    }
}

enum AppTriggers {
    static let appStart = "WM_App_Start"
    static let loginScreen = "WM_Login_Screen"
    static let completedLogin = "WM_Completed_Login"
    static let homeScreen = "WM_Home_Screen"
    static let forecastScreen = "WM_Forecast_Screen"
    static let settingsScreen = "WM_Settings_Screen"
}
