//
//  Service.swift
//  WeatherMate
//
//  Created by Osama Azmat Khan on 27/05/2022.
//

import Foundation
import Alamofire

public protocol NetworkServiceProtocol: AnyObject {
    func execute<T: Codable>(_ urlRequest: URLRequestBuilder, model: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    public static let `default`: NetworkServiceProtocol = {
        var service = NetworkService()
        return service
    }()
    
    func execute<T>(_ urlRequest: URLRequestBuilder, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        
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
                let error = NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "Failed to decode response"])
                completion(.failure(error))
            }
            print("*****************************")
        }
    }
}
