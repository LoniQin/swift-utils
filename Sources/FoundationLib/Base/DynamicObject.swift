//
//  DynamicObject.swift
//  
//
//  Created by lonnie on 2020/10/5.
//

import Foundation
@dynamicCallable
@dynamicMemberLookup
open class DynamicObject {
    
    required public init() {
        
    }
    
    public static var new: Self {
        return Self.init()
    }
    
    var params: [String: Any] = [:]
    
    @discardableResult
    public func dynamicallyCall(withKeywordArguments args: KeyValuePairs<String, Any>) -> Self {
        for item in args {
            params[item.0] = item.1
        }
        return self
    }
    
    public subscript<T>(dynamicMember member: String) -> T where T: Any {
        get {
            params[member] as! T
        }
        set {
            params[member] = newValue
        }
    }
    
    public subscript<T>(dynamicMember member: String) -> T? where T: Any {
        get {
            params[member] as? T
        }
        set {
            params[member] = newValue
        }
    }
    
    public subscript(dynamicMember member: String) -> ()->() {
        get {
            params[member] as! (()->())
        }
        set {
            params[member] = newValue
        }
    }
    
}
