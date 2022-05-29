//
//  Service.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 27/05/2022.
//

import Foundation
import Alamofire
import NotificationBannerSwift

enum NetworkConnnectionError: Error {
    case notConnected
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
                    let banner = FloatingNotificationBanner(title: "Error", subtitle: error.localizedDescription, style: .warning)
                    banner.show()
                    let error = NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "Failed to decode response"])
                    completion(.failure(error))
                }
                print("*****************************")
            }
            
        } else {
            completion(.failure(NetworkConnnectionError.notConnected))
            LoaderManager.instance.hide()
            let banner = FloatingNotificationBanner(title: "Error", subtitle: "Internet Not Connected", style: .warning)
            banner.show()
        }
    }
}
