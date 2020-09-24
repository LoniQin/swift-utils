//
//  Bag.swift
//  
//
//  Created by lonnie on 2020/9/20.
//

import Foundation
public class Bag<T>: Countable, Sequence {
    
    public typealias Element = T
    
    public typealias Iterator = ListNode<T>.Iterater
    
    fileprivate(set) public var first: ListNode<T> = .leaf
    
    fileprivate(set) public var count: Int = 0
    
    public func add(_ value: T) {
        first = .value(value, first)
        count += 1
    }
   
    public __consuming func makeIterator() -> Iterator {
        ListNode.Iterater(node: first)
    }
    
    deinit {
        var flag = true
        while flag {
            switch first {
            case .leaf:
                first = .leaf
                flag = false
            case .value(_, let node):
                first = node
            }
        }
    }
    
}

public extension Bag {
    
    func add(@ArrayBuilder _ builder: () -> [T]) {
        
        for item in builder() {
            add(item)
        }
        
    }
    
}
