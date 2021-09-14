//
//  Quick3WayStringSortTestCase.swift
//  
//
//  Created by Lonnie on 2020/12/30.
//

import Foundation
import XCTest
@testable import SwiftUtils

final class Quick3WayStringSortTestCase: XCTestCase {
    
    func testQuick3WayStringSort() throws {
        var items = [String]()
        for _ in 0..<1.million {
            items.append(Int.random(in: 1..<9999999999).description)
        }
        let result = items
        let sorter = Quick3WayStringSort()
        try DebugLogger.default.measure {
            sorter.sort(&items)
        }
        items.assert.equal(result.sorted())
    }
    
    func testNativeStringSort() throws {
        var items = [String]()
        for _ in 0..<1.million {
            items.append(Int.random(in: 1..<9999999999).description)
        }
        let result = items
        try DebugLogger.default.measure {
            items.sort()
        }
        items.assert.equal(result.sorted())
    }
    
    func testQuick3WayDuplicateStringSort() throws {
        var items = [String]()
        for _ in 0..<1.million {
            let lo = 10000000
            items.append(Int.random(in: lo..<lo + 1000).description)
        }
        let result = items
        let sorter = Quick3WayStringSort()
        try DebugLogger.default.measure {
            sorter.sort(&items)
        }
        items.assert.equal(result.sorted())
    }
    
    func testNativeDuplicateStringSort() throws {
        var items = [String]()
        for _ in 0..<1.million {
            let lo = 10000000
            items.append(Int.random(in: lo..<lo + 1000).description)
        }
        let result = items
        try DebugLogger.default.measure {
            items.sort()
        }
        items.assert.equal(result.sorted())
    }
    
    func testQuick3WayDuplicateStringSort2() throws {
        try DebugLogger.default.measure {
            for _ in 0..<64 {
                for _ in 0..<1.million {
                    
                }
            }
        }
    }
    
}
