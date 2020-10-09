//
//  DynamicObject.swift
//  
//
//  Created by lonnie on 2020/10/5.
//

import Foundation
open class DynamicObject: NSObject, DynamicMemberLookupable, DynamicNewable {
    
    required public override init() {
        super.init()
    }
    
    public var params: [String: Any] = [:]
    
    public subscript(dynamicMember member: String) -> ()->() {
        get {
            params[member] as! (()->())
        }
        set {
            params[member] = newValue
        }
    }
    
}
