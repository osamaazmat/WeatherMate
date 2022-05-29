//
//  AppSettings.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 27/05/2022.
//

import Foundation

enum AppEnvironment {
    case production
    case development
}

extension AppEnvironment {
    static var currentState: AppEnvironment {
        return .development
    }
}

//swiftlint:disable force_unwrapping
extension AppEnvironment {
    static var baseURL: URL {
        switch AppEnvironment.currentState {
        case .production:
            return URL(string: AppURLs.production)!
        case .development:
            return URL(string: AppURLs.development)!
        }
    }
}

extension AppEnvironment {
    static var showLog: Bool {
        switch AppEnvironment.currentState {
        case .production:
            return false
        case .development:
            return true
        }
    }
}
