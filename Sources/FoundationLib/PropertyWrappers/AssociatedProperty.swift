//
//  AssociatedProperty.swift
//  
//
//  Created by lonnie on 2020/8/20.
//

import Foundation
import Foundation
fileprivate var ExtensionPropertyKey = "ExtensionPropertyKey"
@propertyWrapper
public struct AssociatedProperty<T> {
    
    var object = NSObject()
    
    var policy: objc_AssociationPolicy
    
    public init(policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_COPY) {
        self.policy = policy
    }
 
    public var wrappedValue: T? {
        
        get { return objc_getAssociatedObject(object, &ExtensionPropertyKey) as? T }
        
        set { objc_setAssociatedObject(object, &ExtensionPropertyKey, newValue, policy) }
    }

}
