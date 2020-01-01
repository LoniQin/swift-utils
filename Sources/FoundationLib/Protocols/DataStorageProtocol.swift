//
//  DataStorageProtocol.swift
//  
//
//  Created by lonnie on 2020/8/21.
//

import Foundation

public protocol DataStorageProtocol  {
    
    func get<T: Codable>(for key: CustomStringConvertible) throws -> T
    
    func set<T: Codable>(_ value: T?, for key: CustomStringConvertible) throws
    
    func load() throws
    
    func save() throws
    
}

public extension DataStorageProtocol {
    
    func get<T: ExpressibleByNilLiteral & Codable>(for key: CustomStringConvertible) -> T? {
        do {
            let value: T = try get(for: key)
            return value
        } catch  {
            return nil
        }
    }
    
}
