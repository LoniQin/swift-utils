//
//  Stack.swift
//  
//
//  Created by lonnie on 2020/9/20.
//

import Foundation
public struct Stack<T> {
    
    public var items: [T] = []
    
    var isEmpty: Bool {
        items.isEmpty
    }
    
    public mutating func push(_ item: T) {
        items.append(item)
    }
    
    public mutating func pop() throws -> T {
        guard let last = items.popLast() else {
            throw FoundationError.nilValue
        }
        return last
    }
    
}


extension Stack: Codable where T: Codable {
    
}

extension Stack: Equatable where T: Equatable {
    
}
