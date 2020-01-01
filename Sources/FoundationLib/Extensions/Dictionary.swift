//
//  Dictionary.swift
//  
//
//  Created by lonnie on 2020/1/1.
//

import Foundation

public extension Dictionary {
    
    @discardableResult
    func get<T>(_ key: Key) throws -> T {
        if let value: T = self[key] as? T { return value }
        throw FoundationError.nilValue
    }
    
    @discardableResult
    func get<T: ExpressibleByNilLiteral>(_ key: Key) -> T {
        if let value: T = self[key] as? T { return value }
        return nil
    }
    
}
