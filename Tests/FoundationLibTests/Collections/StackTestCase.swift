
//
//  StackTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import FoundationLib

final class StackTestCase: XCTestCase {
    
    func testStack() throws {
        let stack = Stack<Int>()
        stack.push {
            3
            4
            5
        }
        try stack.peek().assert.equal(5)
        try stack.pop().assert.equal(5)
        try stack.peek().assert.equal(4)
        try stack.pop().assert.equal(4)
        try stack.peek().assert.equal(3)
        try stack.pop().assert.equal(3)
        do {
            let stack = Stack<Int>()
            try stack.pop()
            XCTFail()
        } catch {
            
        }
        
    }

    func testStackPerformance() throws {
        let stack = Stack<Int>()
        try DebugLogger.default.measure(description: "Append item in stack") {
            for i in 0..<1.million {
                stack.push(i)
            }
        }
        try DebugLogger.default.measure(description: "Iterate item in stack") {
            for _ in stack {
                
            }
        }
        
        try DebugLogger.default.measure(description: "Remove item in stack") {
            while !stack.isEmpty {
                try stack.pop()
            }
        }
    }
    
}
