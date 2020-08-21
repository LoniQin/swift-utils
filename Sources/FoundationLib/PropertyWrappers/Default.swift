//
//  Default.swift
//  
//
//  Created by lonnie on 2020/8/19.
//

import Foundation
@propertyWrapper
public struct Default<T> {
    
    private var defaultValue: T
    
    var value: T?
    
    public init(_ defaultValue: T) {
        self.defaultValue = defaultValue
    }
 
    public var wrappedValue: T? {
        get { return value ?? defaultValue }
        set { value = newValue }
    }

}
