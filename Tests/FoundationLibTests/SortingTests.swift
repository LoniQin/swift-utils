//
//  SortingTests.swift
//  
//
//  Created by lonnie on 2020/10/12.
//

import Foundation

import XCTest
@testable import FoundationLib

final class SortingTests: XCTestCase {
    
    func testSorting() throws {
        var array = [Int]()
        for i in 0..<100 {
            for _ in 0..<100 {
                array.append(i)
            }
        }
        let shuffled = array.shuffled()
        try SortingAlgorithm.allCases.forEach { algorithm in
            var arr = shuffled
            try DebugLogger.default.measure(desc: "Test \(algorithm) sorting algorithm") {
                arr.sort(algorithm: algorithm, comparator: <)
            }
            (arr == array).assert.true()
        }
    }
    
    func testSortingLargeArray() throws {
        let array = (1..<1000000).map { $0 }
        let shuffled = array.shuffled()
        
        try [SortingAlgorithm.native, SortingAlgorithm.quick, SortingAlgorithm.quick3Way, SortingAlgorithm.heap].forEach { algorithm in
            var arr = shuffled
            try DebugLogger.default.measure(desc: "Test \(algorithm) sorting algorithm") {
                arr.sort(algorithm: algorithm, comparator: <)
            }
            (arr == array).assert.true()
        }
    }
    
}
