
//
//  BitArrayTestCase.swift
//
//
//  Created by lonnie on 2020/10/18.
//

import Foundation
import XCTest
@testable import FoundationLib

final class BitArrayTestCase: XCTestCase {
    
    func testBitArray() throws {
        let bitArray = BitArray(0..<1000)
        for i in 0..<1000 {
            try bitArray.add(i)
        }
        for i in 0..<1000 {
            bitArray.contains(i).assert.true()
        }
        for i in 0..<1000 {
            try bitArray.remove(i)
        }
        for i in 0..<1000 {
            bitArray.contains(i).assert.false()
        }
    }
    
    func testBitArrayPerformance() throws {
        let quantity = 1.million
        let range = 0..<quantity
        let bitArray = BitArray(range)
        try DebugLogger.default.measure(description: "Insert \(quantity) elements") {
            for i in range {
                try bitArray.add(i)
            }
        }
        try DebugLogger.default.measure(description: "Retrieve \(quantity) elements") {
            for i in range {
                bitArray.contains(i).assert.true()
            }
        }
        
        try DebugLogger.default.measure(description: "Remove \(quantity) elements") {
            for i in range {
                try bitArray.remove(i)
            }
        }
        
    }
    
    func testSetPerformance() throws {
        let quantity = 1.million
        let range = 0..<quantity
        var set = Set<Int>()
        try DebugLogger.default.measure(description: "Insert \(quantity) elements") {
            for i in range {
                set.insert(i)
            }
        }
        try DebugLogger.default.measure(description: "Retrieve \(quantity) elements") {
            for i in range {
                set.contains(i).assert.true()
            }
        }
        
        try DebugLogger.default.measure(description: "Remove \(quantity) elements") {
            for i in range {
                set.remove(i)
            }
        }
        
    }

}
