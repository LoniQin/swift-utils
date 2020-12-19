
//
//  RedBlackTreeTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import FoundationLib
let RED = true
let BLACK = false
final class RedBlackTreeTestCase: XCTestCase {
    
    func testRedBlackTree() throws {
        let tree = RedBlackTree<String, Int>()
        var dictionary = [String: Int]()
        let quantity = 100.thouthand
        let numbers = Array(0..<quantity).shuffled()
        try DebugLogger.default.measure(description: "Insert \(quantity) numbers in RedBlackTree") {
            for i in numbers {
                tree[i.description] = i
            }
        }
        
        try DebugLogger.default.measure(description: "Insert \(quantity) numbers in Dictionary") {
            for i in numbers {
                dictionary[i.description] = i
            }
        }
        
        try DebugLogger.default.measure(description: "Retrieve \(quantity) numbers in RedBlackTree") {
            for i in numbers {
                tree[i.description].assert.equal(i)
            }
        }
        
        try DebugLogger.default.measure(description: "Retrieve \(quantity) numbers in Dictionary") {
            for i in numbers {
                dictionary[i.description]?.assert.equal(i)
            }
        }
    }
    
    func testRedBlackTree2() throws {
        let tree = RedBlackTree<Int, Int>()
        var dictionary = [Int: Int]()
        let quantity = 1.hundred.thouthand
        let numbers = Array(0..<quantity).shuffled()
        try DebugLogger.default.measure(description: "Insert \(quantity) numbers in RedBlackTree") {
            for i in numbers {
                tree[i] = i
            }
        }
        try tree.min().assert.equal(0)
        try tree.max().assert.equal(quantity - 1)
        
        try DebugLogger.default.measure(description: "Insert \(quantity) numbers in Dictionary") {
            for i in numbers {
                dictionary[i] = i
            }
        }
        
        try DebugLogger.default.measure(description: "Retrieve \(quantity) numbers in RedBlackTree") {
            for i in numbers {
                tree[i].assert.equal(i)
            }
        }
        
        try DebugLogger.default.measure(description: "Retrieve \(quantity) numbers in Dictionary") {
            for i in numbers {
                dictionary[i]?.assert.equal(i)
            }
        }
        try DebugLogger.default.measure(description: "Delete min") {
            for i in 0..<quantity {
                try tree.min().assert.equal(i)
                try tree.deleteMin()
            }
            
        }
        for i in numbers {
            tree[i] = i
        }
        
        try DebugLogger.default.measure(description: "Delete max") {
            for i in (0..<quantity).reversed() {
                try tree.max().assert.equal(i)
                try tree.deleteMax()
            }
            
        }
    }
    
    func testRedBlackTreeForSorting() throws {
        
        class RedBlackBSTForSorting<Key: Comparable> {
            
            var root: Node? = nil
            
            private func isRed(_ node: Node?) -> Bool {
                node?.color == RED
            }

            func put(_ key: Key) {
                put(&root, key)
            }
            
            private func put(_ node: inout Node?, _ key: Key) {
                guard node != nil else {
                    node = Node(key: key)
                    return
                }
                if key < node!.key {
                    put(&node!.left, key)
                } else if key > node!.key {
                    put(&node!.right, key)
                } else {
                    node?.repeatCount += 1
                }
                // Rotate left
                if let x = node?.right, isRed(x), !isRed(node?.left) {
                    node?.right = x.left
                    x.left = node
                    x.color = x.left!.color
                    x.left?.color = RED
                    node = x
                }
                // Rotate right
                if let x = node?.left, isRed(x), isRed(x.left) {
                    node?.left = x.right
                    x.right = node
                    x.color = x.right!.color
                    x.right?.color = RED
                    node = x
                }
                // Flip Colors
                if isRed(node?.left) && isRed(node?.right) {
                    node?.left?.color = BLACK
                    node?.right?.color = BLACK
                    node?.color = RED
                }
            }
            
            var items: [Key] = []
            
            func inorder() -> [Key] {
                items.removeAll()
                inorder(root)
                return items
            }
            
            func inorder(_ node: Node?) {
                if node == nil { return }
                inorder(node?.left)
                for _ in 0..<node!.repeatCount {
                    items.append(node!.key)
                }
                inorder(node?.right)
            }
            
            typealias Color = Bool

            final class Node {
                
                var key: Key
                
                var left, right: Node?
                
                var color: Color
                
                var repeatCount: UInt16 = 1
                
                public init(
                    key: Key,
                    left: Node? = nil,
                    right: Node? = nil,
                    color: Color = RED
                ) {
                    self.key = key
                    self.left = left
                    self.right = right
                    self.color = color
                }
                
            }
            
        }

        func sortArray(_ items: [Int]) -> [Int] {
            nums.reduce(into: RedBlackBSTForSorting<Int>()) {
                $0.put($1)
            }.inorder()
        }
        
        let nums = (0..<1.million).shuffled()
        var sorted = [Int]()
        try DebugLogger.default.measure {
            sorted = sortArray(nums)
        }
        sorted.assert.equal(Array(0..<1.million))
    }
    
    func testHashTable() {
        let table = SeparateChainingHashTable<Int, Int>()
        for i in 0..<1000 {
            table.put(i, i)
        }
        for i in 0..<1000 {
            table.get(i)?.assert.equal(i)
        }
    }
    
    func testLinearProbingHashTable() {
        let table = LinearProbingHashTable<Int, Int>()
        for i in 0..<100 {
            table.put(i, i)
        } 
        for i in 0..<100 {
            table.delete(i)
        }
    }
    
    func testHashTablePerformance() throws {
        let table = SeparateChainingHashTable<Int, Int>()
        var dictionary = Dictionary<Int, Int>()
        let value = 1000.thouthand
        try DebugLogger.default.measure(description: "Insert \(value) node in HashTable") {
            for i in 0..<value {
                table.put(i, i)
            }
        }
        
        try DebugLogger.default.measure(description: "Retrieve \(value) node in HashTable") {
            for i in 0..<value {
                table.get(i).assert.equal(i)
            }
        }
        
        try DebugLogger.default.measure(description: "Insert \(value) node in Dictionary") {
            for i in 0..<value {
                dictionary[i] = i
            }
        }
        
        try DebugLogger.default.measure(description: "Retrieve \(value) node in HashTable") {
            for i in 0..<value {
               XCTAssert(dictionary[i] == i)
            }
        }
    }
    
    func testLinearProbingHashTablePerformance() throws {
        let table = LinearProbingHashTable<Int, Int>()
        var dictionary = Dictionary<Int, Int>()
        let value = 1.million
        try DebugLogger.default.measure(description: "Insert \(value) node in HashTable") {
            for i in 0..<value {
                table.put(i, i)
            }
        }
        
        try DebugLogger.default.measure(description: "Retrieve \(value) node in HashTable") {
            for i in 0..<value {
                table.get(i).assert.equal(i)
            }
        }
        
        try DebugLogger.default.measure(description: "Delete \(value) node in HashTable") {
            for i in 0..<value {
                table.delete(i)
            }
        }
        
        try DebugLogger.default.measure(description: "Insert \(value) node in Dictionary") {
            for i in 0..<value {
                dictionary[i] = i
            }
        }
        
        try DebugLogger.default.measure(description: "Retrieve \(value) node in HashTable") {
            for i in 0..<value {
               XCTAssert(dictionary[i] == i)
            }
        }
    }
    class AllOne {
        var dic = [String: Int]()
        let tree = RedBlackTree<Int, [String]>()
        /** Initialize your data structure here. */
        init() {
            
        }
        
        /** Inserts a new key <Key> with value 1. Or increments an existing key by 1. */
        func inc(_ key: String) {
            if let value = dic[key] {
                var arr = tree[value]!
                arr.remove(at: arr.firstIndex(of: key)!)
                if arr.isEmpty {
                    tree[value] = nil
                } else {
                    tree[value] = arr
                }
                var arr2 = tree[value + 1] ?? []
                arr2.append(key)
                tree[value + 1] = arr2
                dic[key] = value + 1
            } else {
                dic[key] = 1
                var arr = tree[1] ?? []
                arr.append(key)
                tree[1] = arr
            }
            print(dic)
        }
        
        /** Decrements an existing key by 1. If Key's value is 1, remove it from the data structure. */
        func dec(_ key: String) {
            if let value = dic[key] {
                if value > 1 {
                    var arr = tree[value] ?? []
                    arr.remove(at: arr.firstIndex(of: key)!)
                    if arr.isEmpty {
                        tree[value] = nil
                    } else {
                        tree[value] = arr
                    }
                    dic[key] = value - 1
                    var arr2 = tree[value - 1] ?? []
                    arr2.append(key)
                    tree[value - 1] = arr2
                } else {
                    var arr = tree[1] ?? []
                    arr.remove(at: arr.firstIndex(of: key)!)
                    if arr.isEmpty {
                        tree[1] = nil
                    } else {
                        tree[1] = arr
                    }
                    dic[key] = nil
                }
            }
            print(dic)
        }
        
        /** Returns one of the keys with maximal value. */
        func getMaxKey() -> String {
            do {
                let items = try tree.get(tree.max())
                return (items?.first).unwrapped
            } catch {
                return ""
            }
        }
        
        /** Returns one of the keys with Minimal value. */
        func getMinKey() -> String {
            do {
                let items = try tree.get(tree.min())
                return (items?.first).unwrapped
            } catch {
                return ""
            }
        }
    }

    func test2() {
        /*
        ["AllOne","inc","inc","inc","inc","inc","inc","dec", "dec","getMinKey","dec","getMaxKey","getMinKey"]
        [[],["a"],["b"],["b"],["c"],["c"],["c"],["b"],["b"],[],["a"],[],[]]
        */
        let allOne = AllOne()
        allOne.inc("a")
        allOne.inc("b")
        allOne.inc("b")
        allOne.inc("c")
        allOne.inc("c")
        allOne.inc("c")
        allOne.inc("b")
        allOne.dec("b")
        allOne.dec("b")
        print(allOne.getMinKey())
        allOne.dec("a")
        print(allOne.getMaxKey())
        print(allOne.getMinKey())
    }
}

