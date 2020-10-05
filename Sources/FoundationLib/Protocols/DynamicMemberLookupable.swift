//
//  DynamicMemberLookupable.swift
//  
//
//  Created by lonnie on 2020/10/5.
//

import Foundation
@dynamicMemberLookup
public protocol DynamicMemberLookupable: NSObjectProtocol {
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
    
    func get<T>(_ member: String) -> T? {
        params[member] as? T
    }
    
}



