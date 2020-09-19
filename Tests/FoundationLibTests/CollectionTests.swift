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
        stack.push(3)
        stack.push(4)
        stack.push(5)
        stack.array().assert.equal([5, 4, 3])
        try stack.pop().assert.equal(5)
        try stack.pop().assert.equal(4)
        try stack.pop().assert.equal(3)
    }

    func testStackPerformance() throws {
        try DebugLogger.default.measure {
            self.try {
                let stack = Stack<Int>()
                for i in 0..<1000000 {
                    stack.push(i)
                }
                var i = 1000000 - 1
                while !stack.isEmpty {
                    try i.assert.equal(stack.pop())
                    i -= 1
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
    
    func testBag() throws {
        let bag = Bag<Int>()
        bag.add(1)
        bag.add(3)
        bag.add(5)
        bag.array().assert.equal([5, 3, 1])
        measure {
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
