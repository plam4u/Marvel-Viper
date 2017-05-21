//
//  HeroEndpoint.swift
//  Wallamarvel
//
//  Created by Juanjo García Villaescusa on 20/5/17.
//  Copyright © 2017 Juanjo García Villaescusa. All rights reserved.
//

import Foundation

class HeroEndpoint {
    
    func getHeroes(start: Int, count: Int, completion: @escaping (Result<[Hero]>) -> Void) {
       
        searchHeroes(searchString: nil, start: start, count: count) {
            
            response in
            
            completion(response)
        }
    }
    
    func getHeroe(id: Int, completion: @escaping (Result<Hero>) -> Void) {
        
        let endpointString = "https://gateway.marvel.com:443/v1/public/characters/\(id)"
        
        Gateway.shared.request(endpointString, method: .get, parameters: nil) {
            
            response in
            
            guard response.isSuccess else {
                completion(Result.failure(response.error!))
                return
            }
            
            guard let value = response.value as? [String: Any],
                let data = value["data"] as? [String: Any],
                let heroesPayload = data["results"] as? [[String: Any]] else {
                    completion(Result.failure(GatewayError.MalformedResponse))
                    return
            }
            
            guard let heroPayload = heroesPayload.first else {
                return
            }
            
            
            if let hero = try? HeroMapper.mapFromSource(payload: heroPayload) {
                completion(Result.success(hero))
            } else {
                completion(Result.failure(GatewayError.MalformedResponse))
            }
        }
    }
    
    
    func searchHeroes(searchString: String?, start: Int, count: Int, completion: @escaping (Result<[Hero]>) -> Void) {
        
        let endpointString = "https://gateway.marvel.com:443/v1/public/characters"
        
        var parameters: [String: Any] = [:]
        parameters["limit"] = count
        parameters["offset"] = start
        
        if let searchString = searchString {
            parameters["nameStartsWith"] = searchString
        }
        
        Gateway.shared.request(endpointString, method: .get, parameters: parameters) {
            
            response in
            
            guard response.isSuccess else {
                completion(Result.failure(response.error!))
                return
            }
            
            guard let value = response.value as? [String: Any],
                let data = value["data"] as? [String: Any],
                let heroesPayload = data["results"] as? [[String: Any]] else {
                completion(Result.failure(GatewayError.MalformedResponse))
                return
            }
            
            var heroes: [Hero] = []
            for eachHeroPayload in heroesPayload {
                if let hero = try? HeroMapper.mapFromSource(payload: eachHeroPayload) {
                    heroes.append(hero)
                }
            }
            
            completion(Result.success(heroes))
        }
    }

}
