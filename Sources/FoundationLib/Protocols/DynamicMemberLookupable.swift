//
//  DynamicMemberLookupable.swift
//  
//
//  Created by lonnie on 2020/10/5.
//

import Foundation
@dynamicMemberLookup
public protocol DynamicMemberLookupable: class {
    var params: [String: Any] { get set }
}

public extension DynamicMemberLookupable {
    
    subscript<T>(dynamicMember member: String) -> T where T: Any {
        get {
            params[member] as! T
        }
        set {
            params[member] = newValue
        }
    }
    
    subscript<T>(dynamicMember member: String) -> T? where T: Any {
        get {
            params[member] as? T
        }
        set {
            params[member] = newValue
        }
    }
    
    @discardableResult
    func get<T>(_ key: String) throws -> T {
        if let value: T = params[key] as? T { return value }
        throw FoundationError.nilValue
    }
    
    @discardableResult
    func get<T: ExpressibleByNilLiteral>(_ key: String) -> T {
        if let value: T = params[key] as? T { return value }
        return nil
    }
}
