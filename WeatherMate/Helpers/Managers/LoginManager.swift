//
//  LoginManager.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 29/05/2022.
//

import Foundation
import FirebaseAuth

class LoginManager {
    
    static let instance = LoginManager()
    private init() {}
    
    func isUserLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
            CacheManager.instance.removeAllData()
        } catch {
            print("Sign out error")
        }
    }
}
