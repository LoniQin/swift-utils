
//
//  RedBlackTreeTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import FoundationLib

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
    
}
