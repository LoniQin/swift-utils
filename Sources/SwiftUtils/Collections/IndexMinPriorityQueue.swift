//
//  IndexMinPriorityQueue.swift
//  
//
//  Created by Lonnie on 2020/12/25.
//

import Foundation
public class IndexMinPriorityQueue<Key: Comparable>: Countable {
    
    public fileprivate(set) var capacity: Int
    
    public fileprivate(set) var count: Int
    
    private var pq, qp: [Int]
    
    private var keys: [Key?]
    
    public init(_ capacity: Int) {
        self.capacity = capacity
        count = 0
        keys = [Key?](repeating: nil, count: capacity + 1)
        pq = [Int](repeating: 0, count: capacity + 1)
        qp = [Int](repeating: -1, count: capacity + 1)
    }
    
    public func contains(_ i: Int) -> Bool {
        qp[i] != -1
    }
    
    public func insert(_ i: Int, _ key: Key) {
        count += 1
        qp[i] = count
        pq[count] = i
        keys[i] = key
        swim(count)
    }
    
    public func minIndex() -> Int {
        pq[1]
    }
    
    public func minKey() -> Key? {
        keys[pq[1]]
    }
    
    public func deleteMin() -> Int {
        let min = pq[1]
        exchange(1, count)
        count -= 1
        sink(1)
        qp[min] = -1
        keys[min] = nil
        pq[count + 1] = -1
        return min
    }
    
    public func keyOf(_ i: Int) -> Key? {
        return keys[i]
    }
    
    public func changeKey(_ i: Int, _ key: Key) {
        keys[i] = key
        swim(qp[i])
        sink(qp[i])
    }
    
    public func decreaseKey(_ i: Int, _ key: Key) {
        keys[i] = key
        swim(qp[i])
    }
    
    public func increaseKey(_ i: Int, _ key: Key) {
        keys[i] = key
        sink(qp[i])
    }
    
    public func delete(_ i: Int) {
        let index = qp[i]
        exchange(index, count)
        count -= 1
        swim(index)
        sink(index)
        keys[i] = nil
        qp[i] = -1
    }
    
    private func validateIndex(_ i: Int) throws {
        if i < 0 || i >= capacity {
            throw FoundationError.outOfBounds
        }
    }
    
    func greater(_ i: Int, _ j: Int) -> Bool {
        keys[pq[i]]!.compareTo(keys[pq[j]]!) > 0
    }
    
    func swim(_ i: Int) {
        var k = i
        while k > 1 && greater(k / 2, k) {
            exchange(k, k / 2)
            k = k / 2
        }
    }
    
    func sink(_ i: Int) {
        var k = i
        while 2 * k  <= count {
            var j = 2 * k
            if j < count && greater(j, j + 1) { j += 1 }
            if !greater(k, j) { break }
            exchange(k, j)
            k = j
        }
    }
    
    func exchange(_ i: Int, _ j: Int) {
        pq.swapAt(i, j)
        qp[pq[i]] = i
        qp[pq[j]] = j
    }
    
}
