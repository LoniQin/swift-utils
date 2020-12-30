//
//  MSDSortTestCase.swift
//  
//
//  Created by Lonnie on 2020/12/30.
//

import Foundation
import XCTest
@testable import FoundationLib

final class MSDSortTestCaseTestCase: XCTestCase {
    
    func testMSDStringSort() throws {
        var items = [String]()
        for _ in 0..<1000 {
            items.append(Int.random(in: 1..<99999).description)
        }
        let result = items
        items.shuffle()
        let sorter = MSDSort()
        try sorter.sort(&items)
        items.assert.equal(result.sorted())
    }
    
    func testMSDLargeStringSort() throws {
        var items = [String]()
        for _ in 0..<1.million {
            items.append(Int.random(in: 1..<9999999999).description)
        }
        let result = items
        let sorter = MSDSort()
        try DebugLogger.default.measure {
            try sorter.sort(&items)
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
    
}
