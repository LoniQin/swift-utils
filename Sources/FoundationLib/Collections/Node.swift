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
    
    public init(_ value: T, next: Node<T>? = nil) {
        self.value = value
        self.next = next
    }
    
}
