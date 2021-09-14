
//
//  PriorityQueueTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import SwiftUtils

final class PriorityQueueTestCase: XCTestCase {
    
    func testPriorityQueue() throws {
        let queue = PriorityQueue<Int>(comparator: <)
        for i in 0..<100 {
            queue.insert(i)
        }
        var items = [Int]()
        while let top = queue.deleteTop() {
            items.append(top)
        }
        items.assert.equal(Array(0..<100).reversed())
        let queue2 = PriorityQueue<Int>(comparator: >)
        for i in 0..<100 {
            queue2.insert(i)
        }
        items = [Int]()
        while let top = queue2.deleteTop() {
            items.append(top)
        }
        items.assert.equal(Array(0..<100))
        
    }
    
    func testAppendAndRemoveRandomQueue() throws {
        try testAppendAndRemovePriorityQueue(comparator: <, isRandom: true)
        try testAppendAndRemovePriorityQueue(comparator: <, isRandom: false)
        try testAppendAndRemovePriorityQueue(comparator: >, isRandom: true)
        try testAppendAndRemovePriorityQueue(comparator: >, isRandom: false)
    }
    
    func testAppendAndRemovePriorityQueue(comparator: @escaping PriorityQueue<Int>.Comparator, isRandom: Bool) throws {
        let queue = PriorityQueue<Int>(comparator: comparator)
        var items = (1...1.million).map { $0 }
        if isRandom {
            items.shuffle()
        }
        try DebugLogger.default.measure(description: "Append 1 million\(isRandom ? " Random" : "") elements in Priority Queue") {
            for i in items {
                queue.insert(i)
            }
        }
        
        try DebugLogger.default.measure(description: "Remove 1 million\(isRandom ? " Random" : "") elements in Priority Queue") {
            while queue.deleteTop() != nil {
                
            }
        }
    }
    
}
