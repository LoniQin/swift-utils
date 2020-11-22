
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
        let array = (1..<1000000).map { $0 }
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
    
    func testSorting2() {
        class BST<T: Comparable> {
            class Node {
                var value: T
                var count = 1
                var left: Node?
                var right: Node?
                init(_ value: T) {
                    self.value = value
                }
            }
            var root: Node?
            func put(_ value: T) {
                root = put(value, root)
            }
            func put(_ value: T, _ node: Node?) -> Node? {
                if node == nil {
                    return Node(value)
                } else {
                    if value < node!.value  {
                        node?.left = put(value, node?.left)
                    } else if value > node!.value {
                        node?.right = put(value, node?.right)
                    } else {
                        node?.count += 1
                    }
                    return node
                }
            }
            func inorder() -> [T] {
                var array = [T]()
                inorder(root, &array)
                return array
            }
            func inorder(_ node: Node?, _ array: inout [T]) {
                if node == nil { return }
                inorder(node?.left, &array)
                for _ in 0..<node!.count {
                    array.append(node!.value)
                }
                inorder(node?.right, &array)
            }
        }
        class Solution {
            func sortArray(_ nums: [Int]) -> [Int] {
                let nums = nums.shuffled()
                let bst = BST<Int>()
                for item in nums {
                    bst.put(item)
                }
                return bst.inorder()
            }
            
        }
        let array = (1..<100).shuffled()
        let solution = Solution()
        print(solution.sortArray(array))
    }
    
}
