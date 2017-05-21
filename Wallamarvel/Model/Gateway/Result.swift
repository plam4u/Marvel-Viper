//
//  Result.swift
//  Wallamarvel
//
//  Created by Juanjo García Villaescusa on 20/05/17.
//  Copyright © 2016 Juanjo García Villaescusa. All rights reserved.
//

import Foundation

public enum Result<Value> {
    
    case success(Value)
    case failure(Error)
    
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
    
    public var isFailure: Bool {
        switch self {
        case .success:
            return false
        case .failure:
            return true
        }
    }
    
    public var value: Value? {
        switch self {
        case .success(let value):
            return value;
        case .failure:
            return nil;
        }
    }
    
    public var error: Error? {
        switch self {
        case .success:
            return nil;
        case .failure(let error):
            return error
        }
    }
}
