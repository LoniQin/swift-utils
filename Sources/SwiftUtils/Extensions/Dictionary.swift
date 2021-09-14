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
    
    init(@ArrayBuilder _ builder: ()->[(Key, Value)]) {
        self.init()
        for item in builder() {
            self[item.0] = item.1
        }
    }
    
}

public extension Dictionary where Key == String {
    func htmlTagAttribute()-> String {
        sorted {
            $0.key < $1.key
        }.map {
            var result = $0.key
            if let value = $0.value as? String {
                if !value.isEmpty {
                    result.append("=\"\($0.value)\"")
                }
            } else {
                result.append("=\($0.value)")
            }
            return result
        }.joined(separator: " ")
    }
}
