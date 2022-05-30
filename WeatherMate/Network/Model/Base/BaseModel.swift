//
//  BaseModel.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 30/05/2022.
//

import Foundation

public protocol BaseModelProtocol {
    static func getMockSuccess() -> String
    static func getMockFailure() -> String
}
