//
//  CollectionTests.swift
//  
//
//  Created by lonnie on 2020/9/19.
//
import XCTest
import Compression
@testable import FoundationLib
final class CollectionTests: XCTestCase {
   
    func testStack() throws {
        let stack = Stack<Int>()
        stack.push {
            3
            4
            5
        }
        stack.array().assert.equal([5, 4, 3])
        try stack.pop().assert.equal(5)
        try stack.pop().assert.equal(4)
        try stack.pop().assert.equal(3)
        
    }

    func testStackPerformance() throws {
        let stack = Stack<Int>()
        try DebugLogger.default.measure(desc: "Append item in stack") {
            self.try {
                for i in 0..<1000000 {
                    stack.push(i)
                }
            }
        }
        try DebugLogger.default.measure(desc: "Remove item in stack") {
            self.try {
                while !stack.isEmpty {
                    try stack.pop()
                }
            }
        }
    }
    
    func testQueue() throws {
        let queue = Queue<Int>()
        for i in 0..<1000 {
            queue.enqueue(i)
        }
        queue.array().assert.equal((0..<1000).map{ $0 })
        var value = 0
        while !queue.isEmpty {
            try value.assert.equal(queue.dequeue())
            value += 1
        }
    }
    
    func testQueuePerformance() throws {
        let queue = Queue<Int>()
        try DebugLogger.default.measure(desc: "Append item in queue") {
            self.try {
                for i in 0..<1000000 {
                    queue.enqueue(i)
                }
            }
        }
        try DebugLogger.default.measure(desc: "Remove item in queue") {
            self.try {
                while !queue.isEmpty {
                    try queue.dequeue()
                }
            }
        }
    }
    
    func testArrayPerformance() throws {
        var array = Array<Int>()
        try DebugLogger.default.measure(desc: "Append item in array") {
            self.try {
                for i in 0..<1000000 {
                    array.append(i)
                }
            }
        }
        try DebugLogger.default.measure(desc: "Remove item in array") {
            self.try {
                while !array.isEmpty {
                    array.popLast()
                }
            }
        }
    }
    
    func testBag() throws {
        let bag = Bag<Int>()
        bag.add {
            1
            3
            5
        }
        bag.array().assert.equal([5, 3, 1])
        try DebugLogger.default.measure(desc: "Append item in bag") {
            let bag = Bag<Int>()
            self.try {
                for i in 0..<1000000 {
                    bag.add(i)
                }
            }
        }
    }
    
}

extension CollectionTests {
    static var allTests = [
        ("testStack", testStack),
    ]
}
