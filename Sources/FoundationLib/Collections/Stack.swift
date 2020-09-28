//
//  Stack.swift
//  
//
//  Created by lonnie on 2020/9/20.
//
import Foundation

public class Stack<T>: Sequence, Countable {
    
    public typealias Element = T
    
    public typealias Iterator = ListNode<T>.Iterater
    
    fileprivate(set) public var first: ListNode<T> = .leaf
    
    fileprivate(set) public var count: Int = 0
    
    public func push(_ item: T) {
        first = .value(item, first)
        count += 1
    }
    
    @discardableResult
    public func pop() throws -> T {
        guard case .value(let val, let next) = first else {
            throw FoundationError.nilValue
        }
        first = next
        count -= 1
        return val
    }
    
    public __consuming func makeIterator() -> ListNode<T>.Iterater {
        ListNode.Iterater(node: first)
    }
    
    public func peek() throws -> T {
        guard case .value(let val, _) = first else {
            throw FoundationError.nilValue
        }
        return val
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

public extension Stack {
    
    func push(@ArrayBuilder _ builder: () -> [T]) {
        let items = builder()
        for item in items {
            self.push(item)
        }
    }
    
}
