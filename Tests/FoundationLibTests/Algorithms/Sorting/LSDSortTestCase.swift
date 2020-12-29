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
