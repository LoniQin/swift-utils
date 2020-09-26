//
//  KeyPathConfigurable.swift
//  
//
//  Created by lonnie on 2020/9/26.
//

import Foundation
public protocol KeyPathConfigurable {
    
}

public extension KeyPathConfigurable {
    
    @discardableResult
    func set<T>(_ keyPath: ReferenceWritableKeyPath<Self, T>, _ value: T) -> Self {
        self[keyPath: keyPath] = value
        return self
    }
    
}
