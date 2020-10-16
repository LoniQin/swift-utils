
//
//  QueueTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import FoundationLib

final class QueueTestCase: XCTestCase {
    
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
        queue.enqueue {
            1
            2
            3
            4
            5
        }
        Array(queue).assert.equal([1, 2, 3, 4, 5])
    }
    
    func testQueuePerformance() throws {
        let queue = Queue<Int>()
        try DebugLogger.default.measure(description: "Append item in queue") {
            for i in 0..<1.million {
                queue.enqueue(i)
            }
        }
        try DebugLogger.default.measure(description: "Iterate queue") {
            for _ in queue {
                
            }
        }
        try DebugLogger.default.measure(description: "Remove item in queue") {
            while !queue.isEmpty {
                try queue.dequeue()
            }
        }
    }
    
}
