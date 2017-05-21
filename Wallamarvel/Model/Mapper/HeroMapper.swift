//
//  HeroMapper.swift
//  Wallamarvel
//
//  Created by Juanjo García Villaescusa on 20/5/17.
//  Copyright © 2017 Juanjo García Villaescusa. All rights reserved.
//

import Foundation

class HeroMapper: APIMapper {
    
    static func mapFromSource(payload: [String : Any?]) throws -> Hero {
        
        typealias U = Hero
        
        guard let id = payload["id"] as? Int,
            let name = payload["name"] as? String,
            let description = payload["description"] as? String else {
                
                throw GatewayError.MalformedResponse;
        }
        
        var thumbURL: URL?;
        if let thumbnail = payload["thumbnail"] as? [String: String],
            let path = thumbnail["path"],
            let ext = thumbnail["extension"] {
            thumbURL = URL(string: "\(path).\(ext)")
        }
        
        let hero = Hero(heroId: id, name: name, description: (description != "") ? description : nil, thumbURL: thumbURL)
        
        return hero
    }
}
