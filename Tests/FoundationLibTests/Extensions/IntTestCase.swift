
//
//  IntTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import FoundationLib

final class IntTestCase: XCTestCase {
    
    func testInt() {
        let a = 1
        a.int.assert.equal(1)
        a.float.assert.equal(1)
        a.double.assert.equal(1)
        a.uint.assert.equal(1)
        99999.toBinaryString().assert.equal("11000011010011111")
        var value = 3567
        value.increasing().assert.equal(3568)
        value.decreasing().assert.equal(3567)
        
    }
    
    func testComputingPermofrmance() throws {
        let quantity = 1.million
        try DebugLogger.default.measure(description: "Left Shift \(quantity) numbers") {
            var result = 0
            for i in 0..<quantity {
                result = i << 1
            }
            print(result)
        }
        try DebugLogger.default.measure(description: "Right Shift \(quantity) numbers") {
            var result = 0
            for i in 0..<quantity {
                result = i >> 1
            }
            print(result)
        }
        
        try DebugLogger.default.measure(description: "Add \(quantity) numbers") {
            var result = 0
            for i in 0..<quantity {
                result = i + 2
            }
            print(result)
        }
        
        try DebugLogger.default.measure(description: "Minus \(quantity) numbers") {
            var result = 0
            for i in 0..<quantity {
                result = i - 2
            }
            print(result)
        }
        
        try DebugLogger.default.measure(description: "Multiply \(quantity) numbers") {
            var result = 0
            for i in 0..<quantity {
                result = i * 2
            }
            print(result)
        }
        
        try DebugLogger.default.measure(description: "Divide \(quantity) numbers") {
            var result = 0
            for i in 0..<quantity {
                result = i / 2
            }
            print(result)
        }
        
        try DebugLogger.default.measure(description: "Mod \(quantity) numbers") {
            var result = 0
            for i in 0..<quantity {
                result = i % 2
            }
            print(result)
        }
    }
    
}
