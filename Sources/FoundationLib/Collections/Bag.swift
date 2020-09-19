//
//  Bag.swift
//  
//
//  Created by lonnie on 2020/9/20.
//

import Foundation
public class Bag<T>: Countable, NodeStorage {
    
    fileprivate(set) public var first: Node<T>?
    
    fileprivate(set) public var count: Int = 0
    
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
