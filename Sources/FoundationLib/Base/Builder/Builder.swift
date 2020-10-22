//
//  Builder.swift
//  
//
//  Created by lonnie on 2020/9/6.
//

import Foundation

public protocol BuilderClassProtocol: class {
    
    associatedtype T: Any
    
    var value: T? { get set }
    
    init(_ value: T)
    
}

extension BuilderClassProtocol {
    
    @discardableResult
    public func build(block: (T) -> Void) -> Self {
        if let value = value {
            block(value)
        }
        return self
    }
    
    @discardableResult
    public func with<V>(_ keyPath: ReferenceWritableKeyPath<T, V>, _ value: V) -> Self {
        self.value?[keyPath: keyPath] = value
        return self
    }
    
}

public protocol Buildable: class {
    associatedtype BuilderClass: BuilderClassProtocol = Builder<Self>
}

fileprivate var builderKey = "builderKey"

public extension Buildable {
    
    var builder: BuilderClass {
        if let obj = objc_getAssociatedObject(self, &builderKey) as? BuilderClass {
            return obj
        }
        let builder = BuilderClass(self as! Self.BuilderClass.T)
        objc_setAssociatedObject(self, &builderKey, builder, .OBJC_ASSOCIATION_RETAIN)
        return builder
    }
    
}

open class Builder<T: Buildable>: NSObject, BuilderClassProtocol {
    
    weak public var value: T?
    
    required public init(_ value: T) {
        self.value = value
    }
    
}
