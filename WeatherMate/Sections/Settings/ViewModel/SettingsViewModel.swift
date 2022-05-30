//
//  SettingsViewModel.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 30/05/2022.
//

import Foundation

class SettingsViewModel: SettingsViewModelProtocol {
    
    var networkService: NetworkServiceProtocol
    required init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func logout() {
        LoginManager.instance.logOut()
    }
}
