//
//  Bag.swift
//  
//
//  Created by lonnie on 2020/9/20.
//

import Foundation
public class Bag<T> {
    
    private var first: Node<T>?
    
    public var count: Int = 0
    
    public var isEmpty: Bool {
        return first == nil
    }
    
    public func add(_ value: T) {
        first = Node(value, first)
        count += 1
    }
    
    deinit {
        while first != nil {
            first = first?.next
        }
    }
    
}
