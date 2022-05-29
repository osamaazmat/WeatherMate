//
//  Service.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 27/05/2022.
//

import Foundation
import Alamofire

enum NetworkConnnectionError: Error {
    case notConnected
    case failedToDecode
}

public protocol NetworkServiceProtocol: AnyObject {
    func execute<T: Codable>(_ urlRequest: URLRequestBuilder, model: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    public static let `default`: NetworkServiceProtocol = {
        var service = NetworkService()
        return service
    }()
    
    func execute<T>(_ urlRequest: URLRequestBuilder, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        
        if Reachability.isConnectedToNetwork() {
            let request = AF.request(urlRequest)
            
            request.response { [weak request] response in
                print("*****************************")
                
                request.map { debugPrint($0) }
                let responseData = response.data ?? Data()
                do {
                    let responseObject = try JSONDecoder().decode(T.self, from: responseData)
                    print(responseObject)
                    completion(.success(responseObject))
                    
                } catch let error {
                    print(error.localizedDescription)
                    BannerManager.instance.showBanner(title: AppStrings.Banner.Title.error, message: error.localizedDescription)
                    completion(.failure(NetworkConnnectionError.failedToDecode))
                }
                print("*****************************")
            }
            
        } else {
            completion(.failure(NetworkConnnectionError.notConnected))
            LoaderManager.instance.hide()
            BannerManager.instance.showBanner(title: AppStrings.Banner.Title.error, message: AppStrings.Banner.Body.internetNotConnected)
        }
    }
}
