
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
    

    func testCalculator() throws {
        func evaluate(_ string: String) throws -> Double {
            var array: [String] = []
            var number = ""
            for item in string {
                if item == "+" || item == "-" || item == "*" || item == "/" {
                    if !number.isEmpty {
                        array.append(number)
                        number.removeAll()
                    }
                    array.append("\(item)")
                } else {
                    number.append(item)
                }
            }
            if !number.isEmpty {
                array.append(number)
            }
            loop: while array.count > 1 && (array.contains("+") || array.contains("-") || array.contains("*") || array.contains("/"))  {
                while let timesIndex = array.firstIndex(where: {$0 == "*" || $0 == "/"}) {
                    if timesIndex == 0 || timesIndex == array.count - 1 { throw FoundationError.outOfBounds }
                    let char = array[timesIndex]
                    let lhs = Double(array[timesIndex - 1]) ?? 0
                    let rhs = Double(array[timesIndex + 1]) ?? 0
                    array[timesIndex-1...timesIndex+1] = [char == "*" ?  String(lhs * rhs) : String(lhs / rhs)]
                }
                while let timesIndex = array.firstIndex(where: {$0 == "+" || $0 == "-"}) {
                    if timesIndex == 0 || timesIndex == array.count - 1 { throw FoundationError.outOfBounds }
                    let char = array[timesIndex]
                    let lhs = Double(array[timesIndex - 1]) ?? 0
                    let rhs = Double(array[timesIndex + 1]) ?? 0
                    array[timesIndex-1...timesIndex+1] = [char == "+" ?  String(lhs + rhs) : String(lhs - rhs)]
                }
                
            }
            return array.isEmpty ? 0 : (Double(array[0]) ?? 0)
        }
        try evaluate("1+1").assert.equal(2)
        try evaluate("1-2").assert.equal(-1)
        try evaluate("3*2").assert.equal(6)
        try evaluate("24/3").assert.equal(8)
        try evaluate("24/3*4+24").assert.equal(56)
    }
    
}
