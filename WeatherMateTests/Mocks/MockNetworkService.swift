//
//  MockNetworkService.swift
//  WeatherMateTests
//
//  Created by Osama Azmat Khan on 31/05/2022.
//

import Foundation

class MockNetworkService: NetworkServiceProtocol {
    
    public static let instance: NetworkServiceProtocol = MockNetworkService()
    
    private init() {}
    
    func execute<T>(_ urlRequest: URLRequestBuilder, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable, T: Encodable, T: BaseModelProtocol {
        
        let responseString = T.getMockSuccess()
        do {
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let responseObject = try decoder.decode(T.self, from: Data(responseString.utf8))
            print(responseObject)
            completion(.success(responseObject))
            
        } catch let error {
            print(error.localizedDescription)
            BannerManager.instance.showBanner(title: AppStrings.Banner.Title.error, message: error.localizedDescription)
            completion(.failure(NetworkConnnectionError.failedToDecode))
        }
    }
}

class MockNetworkServiceFailure: NetworkServiceProtocol {
    
    public static let instance: NetworkServiceProtocol = MockNetworkServiceFailure()
    
    private init() {}
    
    func execute<T>(_ urlRequest: URLRequestBuilder, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable, T: Encodable, T: BaseModelProtocol {
        
        let responseString = T.getMockFailure()
        do {
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let responseObject = try decoder.decode(T.self, from: Data(responseString.utf8))
            print(responseObject)
            completion(.success(responseObject))
            
        } catch let error {
            print(error.localizedDescription)
            BannerManager.instance.showBanner(title: AppStrings.Banner.Title.error, message: error.localizedDescription)
            completion(.failure(NetworkConnnectionError.failedToDecode))
        }
    }
}
