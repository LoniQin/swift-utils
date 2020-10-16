
//
//  FixedSizePriorityQueueTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import FoundationLib

final class FixedSizePriorityQueueTestCase: XCTestCase {
    
    func topKFrequent(words: [String], _ k: Int) -> [String] {
        var dic = [String: Int]()
        for item in words {
            if let value = dic[item] {
                dic[item] = value + 1
            } else {
                dic[item] = 1
            }
        }
        let queue = FixedSizePriorityQueue<(String, Int)>(capacity: dic.count, comparator: { $0.1 < $1.1 || ($0.1 == $1.1 && $0.0 > $1.0) })
        for item in dic.enumerated() {
            queue.insert(item.offset, item.element)
        }
        var result = [String]()
        while result.count < k && queue.count > 0 {
            result.append(queue.deleteTop()!.0)
        }
        return result
    }
    
    func topKFrequent(nums: [Int], _ k: Int) -> [Int] {
        var dic = [Int: Int]()
        for item in nums {
            if let value = dic[item] {
                dic[item] = value + 1
            } else {
                dic[item] = 1
            }
        }
        let queue = FixedSizePriorityQueue<(Int, Int)>(capacity: dic.count, comparator: { $0.1 < $1.1 })
        for item in dic.enumerated() {
            queue.insert(item.offset, item.element)
        }
        var result = [Int]()
        while result.count < k && queue.count > 0 {
            result.append(queue.deleteTop()!.0)
        }
        return result
    }
    
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        let queue = FixedSizePriorityQueue<Int>(capacity: nums.count, comparator: { $0 < $1 })
        for item in nums.enumerated() {
            queue.insert(item.offset, item.element)
        }
        var result = [Int]()
        while result.count < k && queue.count > 0 {
            result.append(queue.deleteTop()!)
        }
        return result[k - 1]
    }
    
    func testFixSizedPriorityQueue() throws {
        var nums = [Int]()
        for i in 1...1000 {
            for _ in 0..<i {
                nums.append(i)
            }
        }
        nums.shuffle()
        try DebugLogger.default.measure(description: "Append elements in Fixed Size Priority Queue") {
            topKFrequent(nums: nums, 100).assert.equal((901...1000).map { $0 }.reversed())
        }
        var words = [String]()
        for i in 1...1000 {
            for _ in 0..<i {
                words.append(i.description)
            }
        }
        words.shuffle()
        try DebugLogger.default.measure(description: "Append elements in Fixed Size Priority Queue") {
            topKFrequent(words: words, 100).assert.equal((901...1000).map { $0.description }.reversed())
        }
    }
    
}
