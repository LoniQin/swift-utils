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
        var stack = Stack<Int>()
        stack.push(3)
        stack.push(4)
        stack.push(5)
        try stack.pop().assert.equal(5)
        try stack.pop().assert.equal(4)
        try stack.pop().assert.equal(3)
    }
    
    func testStackCodable() throws {
        var stack = Stack<Int>()
        stack.push(3)
        stack.push(4)
        stack.push(5)
        let data = try JSONEncoder().encode(stack)
        let newStack = try JSONDecoder().decode(Stack<Int>.self, from: data)
        stack.assert.equal(newStack)
    }
    
    func testStackPerformance() throws {
        try DebugLogger.default.measure {
            self.try {
                var stack = Stack<Int>()
                for i in 0..<1000000 {
                    stack.push(i)
                }
                while !stack.isEmpty {
                    try stack.pop()
                }
            }
        }
    }
    
    func testQueue() throws {
        let queue = Queue<Int>()
        for i in 0..<100 {
            queue.enqueue(i)
        }
        var value = 0
        while !queue.isEmpty {
            try value.assert.equal(queue.dequeue())
            value += 1
        }
    }
    
    func testQueuePerformance() throws {
        try DebugLogger.default.measure {
            self.try {
                let queue = Queue<Int>()
                for i in 0..<1000000 {
                    queue.enqueue(i)
                }
                while !queue.isEmpty {
                    try queue.dequeue()
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
