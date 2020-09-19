//
//  File.swift
//  
//
//  Created by lonnie on 2020/9/20.
//

import Foundation

public class Queue<T> {
    
    private var first: Node<T>?
    
    private var last: Node<T>?
    
    fileprivate(set) public var count: Int = 0
    
    public var isEmpty: Bool {
        first == nil
    }
    
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
    
    public func dequeue() throws -> T {
        guard let value = first?.value else {
            throw FoundationError.nilValue
        }
        first = first?.next
        if isEmpty { last = nil }
        count -= 1
        return value
    }

}
