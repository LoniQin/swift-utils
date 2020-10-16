//
//  Node.swift
//  
//
//  Created by lonnie on 2020/9/20.
//

import Foundation

public indirect enum ListNode<T> {
    
    public typealias Element = T
    
    public struct Iterater: IteratorProtocol {
        
        public var node: ListNode
        
        mutating public func next() -> T? {
            switch node {
            case .leaf:
                return nil
            case .value(let val, let next):
                self.node = next
                return val
            }
        }
    }
    
    case leaf
    
    case value(T, ListNode)
     
}


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

extension Node: Equatable where T: Equatable {
    
    public static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
        lhs.value == rhs.value
    }
    
}

extension Node: Comparable where T: Comparable {
    
    public static func < (lhs: Node<T>, rhs: Node<T>) -> Bool {
        lhs.value < rhs.value
    }
  
}
