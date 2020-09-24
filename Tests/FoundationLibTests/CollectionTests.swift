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
    
    func testNode() {
        var node = Node<Int>(100)
        for i in 0..<100 {
            node = Node(i, node)
        }
    }
   
    func testStack() throws {
        let stack = Stack<Int>()
        stack.push {
            3
            4
            5
        }
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
        
        try DebugLogger.default.measure(desc: "Iterate item in array") {
            self.try {
                for i in array {
                    
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
        try DebugLogger.default.measure(desc: "Append item in bag") {
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
