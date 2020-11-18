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
    
    fileprivate(set) public var firstNode: ListNode<T>?
    
    fileprivate(set) public var count: Int = 0
    
    public func push(_ item: T) {
        firstNode = ListNode(item, firstNode)
        count += 1
    }
    
    @discardableResult
    public func pop() throws -> T {
        guard let value = firstNode?.value else {
            throw FoundationError.nilValue
        }
        firstNode = firstNode?.next
        count -= 1
        return value
    }
    
    public __consuming func makeIterator() -> ListNode<T>.Iterater {
        ListNode.Iterater(node: firstNode)
    }
    
    public func peek() throws -> T {
        guard let value = firstNode?.value else {
            throw FoundationError.nilValue
        }
        return value
    }
    
    deinit {
        while !isEmpty {
            do {
                _ = try pop()
            } catch {
                
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
