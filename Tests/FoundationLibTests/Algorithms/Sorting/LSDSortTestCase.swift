//
//  LSDSortTestCase.swift
//  
//
//  Created by Lonnie on 2020/12/30.
//

import Foundation
import XCTest
@testable import FoundationLib

final class LSDSortTestCaseTestCase: XCTestCase {
    
    func testLSDStringSort() throws {
        var items = [String]()
        for _ in 0..<1000 {
            items.append(Int.random(in: 10000..<99999).description)
        }
        let result = items
        items.shuffle()
        let sorter = LSDSort()
        try sorter.sort(&items)
        items.assert.equal(result.sorted())
    }
    
    func testLSDLargeStringSort() throws {
        var items = [String]()
        for _ in 0..<1.million {
            items.append(Int.random(in: 1000000000..<9999999999).description)
        }
        let result = items
        let sorter = LSDSort()
        try DebugLogger.default.measure {
            try sorter.sort(&items)
        }
        items.assert.equal(result.sorted())
    }
     
    func testLSDLargeStringNativeSort() throws {
        var items = [String]()
        for _ in 0..<1.million {
            items.append(Int.random(in: 1000000000..<9999999999).description)
        }
        let result = items
        try DebugLogger.default.measure {
            items.sort()
        }
        items.assert.equal(result.sorted())
    }
    
    func testLSDSort() {
        var items = [Int](-100..<100)
        items.shuffle()
        let sorter = LSDSort()
        sorter.sort(&items)
        
        items.assert.equal(Array(-100..<100))
    }
    
    func testSortLargeArrayUsingNativeSort() throws {
        var items = [Int](0..<1.million)
        items.shuffle()
        try DebugLogger.default.measure {
            items.sort()
        }
        items.assert.equal(Array(0..<1.million))
    }
    
    func testSortLargeArrayUsingLSDSort() throws {
        var items = [Int](0..<1.million)
        items.shuffle()
        let sorter = LSDSort()
        try DebugLogger.default.measure {
            sorter.sort(&items)
        }
        items.assert.equal(Array(0..<1.million))
    }
    
    func testSortLargeDuplicateArrayUsingLSDSort() throws {
        var items = [Int](0..<1.million)
        for i in 0..<items.count {
            items[i] %= 1000
        }
        items.shuffle()
        let sorter = LSDSort()
        try DebugLogger.default.measure {
            sorter.sort(&items)
        }
    }
    
}
