//
//  DataStorage.swift
//  
//
//  Created by lonnie on 2020/8/21.
//

import Foundation
@dynamicMemberLookup
public protocol DataStorage  {
    
    func get<T: Codable>(_ key: CustomStringConvertible) throws -> T
    
    func set<T: Codable>(_ value: T?, for key: CustomStringConvertible) throws
    
    func load() throws
    
    func save() throws
    
}

public extension DataStorage {
    
    func load() throws {
        
    }
    
    func save() throws {
        
    }
    
    func get<T: ExpressibleByNilLiteral & Codable>(_ key: CustomStringConvertible) -> T? {
        do {
            let value: T = try get(key)
            return value
        } catch  {
            return nil
        }
    }
    
    subscript<T>(dynamicMember member: String)-> T? where T: Codable {
        get {
            try? get(member)
        }
        set {
           try? set(newValue, for: member)
        }
    }
    
}
