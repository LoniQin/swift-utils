//
//  Builder.swift
//  
//
//  Created by lonnie on 2020/9/6.
//

import Foundation

public protocol Buildable: NSObjectProtocol {
    
}

extension NSObject: Buildable {
    
}

open class Builder<T: Buildable> {
    
    weak var value: T?
    
    public init(_ value: T) {
        self.value = value
    }
    
    @discardableResult
    public func build(block: (T) -> Void) -> Self {
        if let value = value {
            block(value)
        }
        return self
    }
    
}

fileprivate var builderKey = "builderKey"

public extension Buildable {
    
    var builder: Builder<Self> {
        if let obj = objc_getAssociatedObject(self, &builderKey) as? Builder<Self> {
            return obj
        }
        let builder = Builder(self)
        objc_setAssociatedObject(self, &builderKey, builder, .OBJC_ASSOCIATION_RETAIN)
        return builder
    }
    
}
