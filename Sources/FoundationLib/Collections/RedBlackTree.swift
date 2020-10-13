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
    
    public subscript(key: Key) -> Value? {
        set {
            if newValue == nil {
                delete(key)
            } else {
                put(key, newValue)
            }
        }
        get {
            get(key)
        }
    }
    
    private func isRed(_ node: Node?) -> Bool {
        node?.color == .red
    }
    
    private func size(_ node: Node?) -> Int {
        node?.count ?? 0
    }
    
    public var isEmpty: Bool {
        root == nil
    }
    
    public func get(_ key: Key) -> Value? {
        return get(root, key)
    }
    
    private func get(_ node: Node?, _ key: Key) -> Value? {
        var node = node
        while node != nil {
            if key < node!.value.0 {
                node = node?.left
            } else if key > node!.value.0 {
                node = node?.right
            } else {
                return node?.value.1
            }
        }
        return nil
    }
    
    public func contains(_ key: Key) -> Bool {
        get(key) != nil
    }
    
    public func put(_ key: Key, _ value: Value?) {
        if value == nil {
            delete(key)
            return
        }
        root = put(root, key, value!)
        root?.color = .black
    }
    
    private func put(_ node: Node?, _ key: Key, _ value: Value) -> Node? {
        guard node != nil else {
            return Node(key: key, value: value)
        }
        var node = node
        if key < node!.value.0 {
            node?.left = put(node?.left, key, value)
        } else if key > node!.value.0 {
            node?.right = put(node?.right, key, value)
        } else {
            node?.value.1 = value
        }
        
        if isRed(node?.right) && !isRed(node?.left) {
            node = node?.rotateLeft()
        }
        if isRed(node?.left) && isRed(node?.left?.left) {
            node = node?.rotateRight()
        }
        if isRed(node?.left) && isRed(node?.right) {
            node?.flipColors()
        }
        
        node?.count = size(node?.left) + size(node?.right) + 1
        return node
    }
    
    public func deleteMin() throws {
        if isEmpty {
            throw FoundationError.emptyCollection
        }
        if !isRed(root?.left) && !isRed(root?.right) {
            root?.color = .red
        }
        root = deleteMin(root)
        if !isEmpty { root?.color = .black }
        
    }
    
    func deleteMin(_ node: Node?) -> Node? {
        var node: Node? = node
        if node?.left == nil { return nil }
        if !isRed(node?.left) && !isRed(node?.left?.left) {
            node = node?.moveRedLeft()
        }
        if node?.left != nil {
            node?.left = deleteMin(node?.left)
        }
        return balance(node!)
    }
    
    public func deleteMax() throws {
        if isEmpty {
            throw FoundationError.emptyCollection
        }
        if !isRed(root?.left) && !isRed(root?.right) {
            root?.color = .red
        }
        root = deleteMax(root)
        if !isEmpty { root?.color = .black }
        
    }
    
    func deleteMax(_ node: Node?) -> Node? {
        var node: Node? = node
        if isRed(node?.left) {
            node = node?.rotateRight()
        }
        if node?.right == nil { return nil }
        if !isRed(node?.right) && !isRed(node?.right?.left) {
            node = node?.moveRedRight()
        }
        node?.right = deleteMax(node?.right)
        return balance(node)
    }
    
    public func delete(_ key: Key) {
        if !contains(key) { return }
        if (root?.left?.color ?? .black) != .red && (root?.right?.color ?? .black) != .red {
            root?.color = .red
        }
        root = delete(root, key)
    }
    
    private func delete(_ node: Node?, _ key: Key) -> Node? {
        if node == nil { return nil }
        var node = node
        if key < node!.value.0 {
            if !isRed(node?.left)  && !isRed(node?.left?.left) {
                node = node?.moveRedLeft()
            }
            node?.left = delete(node?.left, key)
        } else {
            if isRed(node?.left) {
                node = node?.rotateRight()
            }
            if key == node?.value.0 && node?.right == nil {
                return nil
            }
            if !isRed(node?.right) && !isRed(node?.right?.left) {
                node = node?.moveRedRight()
            }
            if key == node?.value.0  {
                if node?.right == nil {
                    let x = min(node!.right!)
                    node?.value = x.value
                    node?.right = deleteMin(node?.right)
                }
            } else {
                node?.right = delete(node?.right, key)
            }
        }
        return balance(node)
    }
    
    public func min() throws -> Key {
        if isEmpty {
            throw FoundationError.emptyCollection
        }
        return min(root!).value.0
    }
    
    func min(_ node: Node) -> Node {
        node.left == nil ? node : min(node.left!)
    }
    
    func balance(_ node: Node?) -> Node? {
        var node = node
        if isRed(node?.right) {
            node = node?.rotateLeft()
        }
        if isRed(node?.left) && isRed(node?.left?.left) {
            node = node?.rotateRight()
        }
        if isRed(node?.left) && isRed(node?.right) {
            node?.flipColors()
        }
        node?.count = size(node?.left) + size(node?.right) + 1
        return node
    }
    
    public func max() throws -> Key {
        if isEmpty {
            throw FoundationError.nilValue
        }
        return max(root!).value.0
    }
    
    func max(_ node: Node) -> Node {
        node.right == nil ? node : max(node.right!)
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
    
    final class Node {
        
        public var value: (Key, Value)
        
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
            self.value = (key, value)
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
            x.color = right?.color ?? .black
            x.right?.color = .red
            x.count = count
            count = (left?.count ?? 0) + (right?.count ?? 0) + 1
            return x
        }
        
        public func flipColors() {
            color.toggle()
            left?.color.toggle()
            right?.color.toggle()
        }
        
        public func moveRedLeft() -> Node? {
            flipColors()
            var node: Node? = self
            if node?.right?.left?.color == .red {
                node?.right = node?.right?.rotateRight()
                node = node?.rotateLeft()
                node?.flipColors()
            }
            return node
        }
        
        public func moveRedRight() -> Node? {
            flipColors()
            var node: Node? = self
            if node?.left?.left?.color == .red {
                node = node?.rotateRight()
                node?.flipColors()
            }
            return node
        }
        
    }
}

extension RedBlackTree: Countable {
    
}

extension RedBlackTree.Node: BinaryTreeProtocol {
    
}
