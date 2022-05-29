//
//  String+Ext.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 29/05/2022.
//

import Foundation

extension String {
    
    func isValidEmail() -> Bool {
      let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
      let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
      return emailPred.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
      let minPasswordLength = 6
      return self.count >= minPasswordLength
    }
}
