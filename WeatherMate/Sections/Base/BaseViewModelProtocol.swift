//
//  BaseViewModelProtocol.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 30/05/2022.
//

import Foundation

protocol BaseViewModelProtocol: AnyObject {
    var networkService: NetworkServiceProtocol { get }
    init(networkService: NetworkServiceProtocol)
}
