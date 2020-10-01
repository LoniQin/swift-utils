//
//  Configurable.swift
//  
//
//  Created by lonnie on 2020/9/26.
//

import Foundation
public protocol Configurable {
    
}

public extension Configurable {
    
    @discardableResult
    func set<T>(_ keyPath: ReferenceWritableKeyPath<Self, T>, _ value: T) -> Self {
        self[keyPath: keyPath] = value
        return self
    }
    
    @discardableResult
    func then(_ block: @escaping (Self) -> Void) -> Self {
        block(self)
        return self
    }
    
    func `do`(_ block: @escaping (Self) -> Void) {
        block(self)
    }
    
    @discardableResult
    func `with`(_ block: @escaping (Self) -> Void) -> Self {
        block(self)
        return self
    }
    
    @discardableResult
    func with<T>(_ keyPath: ReferenceWritableKeyPath<Self, T>, _ value: T) -> Self {
        self[keyPath: keyPath] = value
        return self
    }
    
}
