//
//  Queue.swift
//  
//
//  Created by lonnie on 2020/9/20.
//

import Foundation

public class Queue<T>: Countable, NodeStorage {
    
    public var first: Node<T>?
    
    var last: Node<T>?
    
    fileprivate(set) public var count: Int = 0
    
    public func enqueue(_ item: T) {
        let oldLast = last
        last = Node(item)
        if isEmpty {
            first = last
        } else {
            oldLast?.next = last
        }
        count += 1
    }
    
    @discardableResult
    public func dequeue() throws -> T {
        guard let value = first?.value else {
            throw FoundationError.nilValue
        }
        first = first?.next
        if isEmpty { last = nil }
        count -= 1
        return value
    }
    
    deinit {
        while first != nil {
            first = first?.next
        }
    }

}


public extension Queue {
    
    func enqueue(@ArrayBuilder _ builder: () -> [T]) {
        
        for item in builder() {
            enqueue(item)
        }
        
    }
    
}
