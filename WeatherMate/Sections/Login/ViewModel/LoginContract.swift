//
//  LoginContract.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 30/05/2022.
//

import Foundation

protocol LoginViewModelProtocol: BaseViewModelProtocol {
    var vcTypeDidChange: ((LoginViewControllerType) -> ())? { get set }
    var didReturnError: ((String) -> ())? { get set }
    var loginSignupCompleted: (() -> ())? { get set}
    func signUp(with email: String, password: String)
    func login(with email: String, password: String)
    func tryAutoLogin()
}
