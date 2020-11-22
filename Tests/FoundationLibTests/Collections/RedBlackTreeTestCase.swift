
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
        print(table.get(125))
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
            for i in 0..<10.thouthand {
               XCTAssert(dictionary[i] == i)
            }
        }
    }
}

