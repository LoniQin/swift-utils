//
//  Array.swift
//  
//
//  Created by lonnie on 2020/1/1.
//

import Foundation

public extension Array {
    
    @discardableResult
    func get<T>(_ index: Int) -> T? {
        if let value = self[index] as? T {
            return value
        }
        return nil
    }
    
    @discardableResult
    func get<T>(_ index: Int) throws -> T {
        if let value: T = self[index] as? T { return value }
        throw FoundationError.nilValue
    }
    
}
