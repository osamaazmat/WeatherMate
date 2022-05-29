//
//  CacheManager.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 28/05/2022.
//

import Foundation
import SwiftKeychainWrapper

fileprivate enum CacheManagerKeys {
    static let email: String = "WM_Email"
    static let password: String = "WM_Password"
}

class CacheManager {
    
    typealias SavedUserData = (Bool, String, String)
    
    static let instance = CacheManager()
    private init() {}
    
    func saveUserData(email: String, password: String) -> Bool {
        let saveEmailSuccessful: Bool = KeychainWrapper.standard.set(email, forKey: CacheManagerKeys.email)
        let savePasswordSuccessful: Bool = KeychainWrapper.standard.set(password, forKey: CacheManagerKeys.password)
        
        return saveEmailSuccessful && savePasswordSuccessful
    }
    
    func getSavedLoginData() -> SavedUserData {
        let retrievedEmailString: String = KeychainWrapper.standard.string(forKey: CacheManagerKeys.email) ?? ""
        let retrievedPasswordString: String = KeychainWrapper.standard.string(forKey: CacheManagerKeys.password) ?? ""
        
        if retrievedEmailString.count > 0, retrievedPasswordString.count > 0 {
            return (true, retrievedEmailString, retrievedPasswordString)
        } else {
            return (false, "", "")
        }
    }
    
    func getUserData() -> UserModel? {
        let retrievedEmailString: String = KeychainWrapper.standard.string(forKey: CacheManagerKeys.email) ?? ""
        
        if retrievedEmailString.count > 0 {
            let userModel = UserModel(email: retrievedEmailString)
            return userModel
        } else {
            return nil
        }
    }
    
    func removeAllData() {
        KeychainWrapper.standard.removeAllKeys()
    }
}
