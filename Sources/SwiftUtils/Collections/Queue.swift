//
//  Queue.swift
//  
//
//  Created by lonnie on 2020/9/20.
//

import Foundation

public class Queue<T>: Sequence, Countable {
    
    public typealias Element = T
    
    public typealias Iterator = ListNode<T>.Iterater
    
    fileprivate(set) public var first: ListNode<T>?
    
    fileprivate(set) public var last: ListNode<T>?
    
    fileprivate(set) public var count: Int = 0
    
    public init() {
        
    }
    
    public func enqueue(_ item: T) {
        let oldLast = last
        last = ListNode(item)
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
            throw FoundationError.emptyCollection
        }
        first = first?.next
        if isEmpty { last = nil }
        count -= 1
        return value
    }
    
    public __consuming func makeIterator() -> ListNode<T>.Iterater {
        ListNode.Iterater(node: first)
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
