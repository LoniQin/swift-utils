//
//  Stack.swift
//  
//
//  Created by lonnie on 2020/9/20.
//

import Foundation

public class Stack<T> {
    
    private var first: Node<T>?
    
    var isEmpty: Bool {
        first == nil
    }
    
    var count: Int = 0
    
    public func push(_ item: T) {
        first = Node(item, first)
        count += 1
    }
    
    @discardableResult
    public func pop() throws -> T {
        guard let value = first?.value else {
            throw FoundationError.nilValue
        }
        first = first?.next
        count -= 1
        return value
    }
    
    public func peek() throws -> T {
        guard let value = first?.value else {
            throw FoundationError.nilValue
        }
        return value
    }
    
    deinit {
        while first != nil {
            first = first?.next
        }
    }
    
}

