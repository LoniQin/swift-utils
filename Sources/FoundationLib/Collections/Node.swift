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
    
    func toArray() -> [T] {
        var node: Node? = self
        var array = [T]()
        while node != nil {
            array.append(node!.value)
            node = node?.next
        }
        return array
    }
    
}

public protocol NodeStorage {
    
    associatedtype T
    
    var first: Node<T>? { get }
    
}

public extension NodeStorage {
    
    func array() -> [T] {
        var node: Node? = first
        var items = [T]()
        while node != nil {
            items.append(node!.value)
            node = node?.next
        }
        return items
    }
    
}
