
//
//  Array_SortingTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import FoundationLib

final class Array_SortingTestCase: XCTestCase {
    
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
            try DebugLogger.default.measure(description: "Test \(algorithm) sorting algorithm") {
                arr.sort(algorithm: algorithm, by: <)
            }
            (arr == array).assert.true()
        }
    }
    
    func testSortingLargeArray() throws {
        let array = (1..<100000).map { $0 }
        let shuffled = array.shuffled()
        
        try [SortingAlgorithm.native, SortingAlgorithm.quick, SortingAlgorithm.quick3Way, SortingAlgorithm.heap, SortingAlgorithm.bucket, SortingAlgorithm.merge].forEach { algorithm in
            var arr = shuffled
            try DebugLogger.default.measure(description: "Test \(algorithm) sorting algorithm") {
                arr.sort(algorithm: algorithm, by: <)
            }
            (arr == array).assert.true()
        }
    }
    
    func testSortingDuplicatedArray() throws {
        var array = [Int]()
        for i in 0..<10000 {
            for _ in 0..<100 {
                array.append(i)
            }
        }
        let shuffled = array.shuffled()
        try [SortingAlgorithm.native, SortingAlgorithm.quick, SortingAlgorithm.quick3Way, SortingAlgorithm.heap, SortingAlgorithm.bucket, SortingAlgorithm.merge].forEach { algorithm in
            var arr = shuffled
            try DebugLogger.default.measure(description: "Test \(algorithm) sorting algorithm") {
                arr.sort(algorithm: algorithm, by: <)
            }
            (arr == array).assert.true()
        }
    }
    
    func testSelectionSort() {
        var array = (1..<100).shuffled()
        array.selectionSort(by: <)
        array.shuffle()
        array.selectionSort(by: >)
        array.assert.equal(Array(1..<100).reversed())
    }
    
    func testInsertingSort() {
        var array = (1..<100).shuffled()
        array.insertionSort(by: <)
        array.shuffle()
        array.insertionSort(by: >)
        array.assert.equal(Array(1..<100).reversed())
    }
    
}
