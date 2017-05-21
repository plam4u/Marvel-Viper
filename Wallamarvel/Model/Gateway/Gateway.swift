//
//  Gateway.swift
//  Wallamarvel
//
//  Created by Juanjo García Villaescusa on 20/05/17.
//  Copyright © 2016 Juanjo García Villaescusa. All rights reserved.
//

import Alamofire
import CryptoSwift

protocol APIMapper {
    
    associatedtype U
    
    static func mapFromSource(payload: [String: Any?]) throws -> U
}

enum GatewayError: Error {
    case EndPointNotAvailable
    case MalformedResponse
    case MissingKeys
}

public enum GatewayMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public class Gateway {
    
    static let shared = Gateway()
    
    var apiPublicKey: String?
    var apiPrivateKey: String?
    
    private init() {
        try? getApiKeys {
            publicKey, privateKey in
            
            apiPublicKey = publicKey
            apiPrivateKey = privateKey
        }
    }
    
    func request(_ url: String, method: GatewayMethod = .get, parameters:[String: Any]? = nil, completionHandler:((Result<Any>) -> ())? = nil) {
        
        // makes sure keys are present
        guard let publicKey = apiPublicKey, let privateKey = apiPrivateKey else {
                completionHandler?(Result.failure(GatewayError.MissingKeys))
                return
        }
        
        // parameters enconding and http method
        let encoding =  URLEncoding.default;
        let httpMethod = HTTPMethod(rawValue: method.rawValue)!
        
        // add auth parameters and work out hash to access Marvel APi
        let timeStamp = Date().timeIntervalSince1970.description
        var allParameters: [String: Any] = [:]
        allParameters["apikey"] = publicKey
        allParameters["ts"] = timeStamp.description
        allParameters["hash"] = (timeStamp + privateKey + publicKey).md5()
        
        // adding passed parameters
        if let parameters = parameters {
            for (key, value) in parameters {
                allParameters[key] = value
                allParameters[key] = value
            }
        }
        
        // request
        Alamofire.request(url, method: httpMethod, parameters: allParameters, encoding: encoding, headers: nil).validate().responseJSON {
            
            response in
            
            guard response.result.isSuccess else {
                completionHandler?(.failure(response.result.error!))
                return;
            }
            
            completionHandler?(Result.success(response.result.value!))
        }
    }
    
    private func getApiKeys(completionHandler: (String, String) -> Void) throws -> Void {
        
        guard  let keysFile = Bundle.main.path(forResource: "apikeys", ofType: "plist"),
            let keys = NSDictionary(contentsOfFile: keysFile),
            let privateKey = keys["privateKey"] as? String,
            let publicKey = keys["publicKey"] as? String else {
                throw GatewayError.MissingKeys
        }
        
        completionHandler(publicKey, privateKey)
    }
}
