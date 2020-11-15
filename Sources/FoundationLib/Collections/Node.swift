//
//  Node.swift
//  
//
//  Created by lonnie on 2020/9/20.
//

import Foundation

public class Node<T> {
    
    public var value: T
    
    public var next: Node<T>?
    
    public init(_ value: T, _ next: Node<T>? = nil) {
        self.value = value
        self.next = next
    }
    
    public struct Iterater: IteratorProtocol {
        
        public var node: Node?
        
        mutating public func next() -> T? {
            defer {
                node = node?.next
            }
            return node?.value
        }
    }
    
}
