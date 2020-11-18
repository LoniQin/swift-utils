//
//  Node.swift
//  
//
//  Created by lonnie on 2020/9/20.
//

import Foundation

public class ListNode<T>: Sequence {
    
    public var value: T
    
    public var next: ListNode<T>?
    
    public init(_ value: T, _ next: ListNode<T>? = nil) {
        self.value = value
        self.next = next
    }
    
    public struct Iterater: IteratorProtocol {
        
        public var node: ListNode?
        
        mutating public func next() -> T? {
            defer {
                node = node?.next
            }
            return node?.value
        }
    }
    
    public func makeIterator() -> Iterater {
        Iterater(node: self)
    }
    
}
