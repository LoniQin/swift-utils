//
//  DynamicObject.swift
//  
//
//  Created by lonnie on 2020/10/5.
//

import Foundation
@dynamicCallable
open class DynamicObject: NSObject, DynamicMemberLookupable {
    
    required public override init() {
        super.init()
    }
    
    public static var new: Self {
        return Self.init()
    }
    
    public var params: [String: Any] = [:]
    
    @discardableResult
    public func dynamicallyCall(withKeywordArguments args: KeyValuePairs<String, Any>) -> Self {
        for item in args {
            params[item.0] = item.1
        }
        return self
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
