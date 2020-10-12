//
//  RedBlackTree.swift
//  
//
//  Created by lonnie on 2020/10/12.
//

import Foundation

public class RedBlackTree<Key: Comparable, Value: Comparable> {
    
    public var root: Node? = nil
    
    public var count: Int { root?.count ?? 0 }
    
    public init() {
        
    }
    
    public subscript(key: Key) -> Value {
        set {
            put(key: key, value: newValue)
        }
        get {
            get(key: key)!
        }
    }
    
    public func put(key: Key, value: Value) {
        root = put(node: root, key: key, value: value)
        root?.color = .black
    }
    
    private func put(node: Node?, key: Key, value: Value) -> Node? {
        guard node != nil else {
            return Node(key: key, value: value)
        }
        var node = node
        if key < node!.key {
            node?.left = put(node: node?.left, key: key, value: value)
        } else if key > node!.key {
            node?.right = put(node: node?.right, key: key, value: value)
        } else {
            node?.value = value
        }
        if node?.right?.color == .red && node?.left?.color != .red {
            node = node?.rotateLeft()
        }
        if node?.left?.color == .red && node?.left?.left?.color == .red {
            node = node?.rotateRight()
        }
        if node?.left?.color == .red && node?.right?.color == .red {
            node?.flipColors()
        }
        return node
    }
    
    public func get(key: Key) -> Value? {
        return get(node: root, key: key)
    }
    
    private func get(node: Node?, key: Key) -> Value? {
        var node = node
        while node != nil {
            if key < node!.key {
                node = node?.left
            } else if key > node!.key {
                node = node?.right
            } else {
                return node?.value
            }
        }
        return nil
    }

}

public extension RedBlackTree {
    
    enum Color {
        
        case red
        
        case black
        
        mutating func toggle() {
            switch self {
            case .red:
                self = .black
            case .black:
                self = .red
            }
        }
        
    }
    
    class Node {
        
        public var key: Key
        
        public var value: Value
        
        public var left: Node?
        
        public var right: Node?
        
        public var count: Int
        
        public var color: Color
        
        public init(
            key: Key,
            value: Value,
            left: Node? = nil,
            right: Node? = nil,
            count: Int = 1,
            color: Color = .red
        ) {
            self.key = key
            self.value = value
            self.left = left
            self.right = right
            self.count = count
            self.color = color
        }
        
        public func rotateLeft() -> Node? {
            guard let x = right else {
                return nil
            }
            right = x.left
            x.left = self
            x.color = x.left?.color ?? .black
            x.left?.color = .red
            x.count = count
            count = (left?.count ?? 0) + (right?.count ?? 0) + 1
            return x
        }
        
        public func rotateRight() -> Node? {
            guard let x = left else {
                return nil
            }
            left = x.right
            x.right = self
            x.color = color
            color = .red
            x.count = count
            count = (left?.count ?? 0) + (right?.count ?? 0) + 1
            return x
        }
        
        public func flipColors() {
            color = .red
            left?.color.toggle()
            right?.color.toggle()
        }
        
    }
}

extension RedBlackTree: Countable {
    
}
