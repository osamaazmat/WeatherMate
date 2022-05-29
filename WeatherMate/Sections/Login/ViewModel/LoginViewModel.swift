//
//  LoginViewModel.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 30/05/2022.
//

import Foundation
import FirebaseAuth

class LoginViewModel: LoginViewModelProtocol {
    var didReturnError: ((String) -> ())?
    var loginSignupCompleted: (() -> ())?
    var vcTypeDidChange: ((LoginViewControllerType) -> ())?
    
    func tryAutoLogin() {
        let (isAvailable, email, password) = CacheManager.instance.getSavedLoginData()
        if isAvailable {
            login(with: email, password: password)
        } else {
            self.vcTypeDidChange?(.login)
        }
    }
    
    func signUp(with email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            
            guard let strongSelf = self else {
                return
            }
            
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                default:
                    debugPrint("Error: \(error.localizedDescription)")
                    strongSelf.didReturnError?(error.localizedDescription)
                }
            } else {
                debugPrint("User signs up successfully")
                let newUserInfo = Auth.auth().currentUser
                let email = newUserInfo?.email
                if let email = email {
                    let isSaved = CacheManager.instance.saveUserData(email: email, password: password)
                    DispatchQueue.main.async {
                        if isSaved {
                            strongSelf.loginSignupCompleted?()
                        } else {
                            strongSelf.vcTypeDidChange?(.signup)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        strongSelf.vcTypeDidChange?(.signup)
                    }
                }
            }
        }
    }
    
    func login(with email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            
            guard let strongSelf = self else {
                return
            }
            
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                default:
                    debugPrint("Error: \(error.localizedDescription)")
                    strongSelf.didReturnError?(error.localizedDescription)
                }
            } else {
                debugPrint("User Login up successfully")
                let newUserInfo = Auth.auth().currentUser
                let email = newUserInfo?.email
                if let email = email {
                    let isSaved = CacheManager.instance.saveUserData(email: email, password: password)
                    DispatchQueue.main.async {
                        if isSaved {
                            strongSelf.loginSignupCompleted?()
                        } else {
                            strongSelf.vcTypeDidChange?(.signup)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        strongSelf.vcTypeDidChange?(.signup)
                    }
                }
            }
        }
    }
}
