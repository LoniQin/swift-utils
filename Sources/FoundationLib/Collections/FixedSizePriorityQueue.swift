//
//  FixedSizePriorityQueue.swift
//  
//
//  Created by lonnie on 2020/10/11.
//

import Foundation

public class FixedSizePriorityQueue<Element>: Countable {
    
    public let capacity: Int
    
    public fileprivate(set) var count: Int
    
    private var pq, qp: [Int]
    
    private var elements: [Element?]
    
    public let comparator: ((Element, Element)-> Bool)
    
    public init(capacity: Int, comparator: @escaping ((Element, Element)-> Bool)) {
        self.capacity = capacity
        self.comparator = comparator
        count = 0
        pq = Array(repeating: 0, count: capacity + 1)
        qp = Array(repeating: -1, count: capacity + 1)
        elements = Array(repeating: nil, count: capacity + 1)
    }
    
    public func contains(_ i: Int) -> Bool {
        return qp[i] != -1
    }
    
    public func insert(_ i: Int, _ element: Element) {
        count += 1
        qp[i] = count
        pq[count] = i
        elements[i] = element
        swim(count)
    }
    
    public func topIndex() -> Int {
        return pq[1]
    }
    
    public func topElement() -> Element? {
        return elementOf(topIndex())
    }
    
    public func deleteTop() -> Element? {
        if isEmpty {
            return nil
        }
        let element = topElement()
        let min = pq[1]
        exchange(1, count)
        count -= 1
        sink(1)
        qp[min] = -1
        elements[min] = nil
        pq[count + 1] = -1
        return element
    }
    
    public func elementOf(_ i: Int) -> Element? {
        return elements[i]
    }
    
    public func changeKey(_ i: Int, _ key: Element) {
        elements[i] = key
        swim(qp[i])
        sink((qp[i]))
    }
    
    public func compare(_ i: Int, _ j: Int) -> Bool {
        return comparator(elements[pq[i]]!, elements[pq[j]]!)
    }
    
    public func delete(_ i: Int) {
        let index = qp[i]
        exchange(index, count)
        count -= 1
        swim(index)
        sink(index)
        elements[i] = nil
        qp[i] = -1
    }
    
    public func exchange(_ i: Int, _ j: Int) {
        pq.swapAt(i, j)
        qp[pq[i]] = i
        qp[pq[j]] = j
    }
    
    private func swim(_ k: Int) {
        var k = k
        while k > 1 && compare(k >> 1, k) {
            pq.swapAt(k >> 1, k)
            k >>= 1
        }
    }

    private func sink(_ k: Int) {
        var k = k
        while (k << 1) <= count {
            var j = (k << 1)
            if j < count && compare(j, j + 1) { j += 1 }
            if !compare(k, j) { break }
            pq.swapAt(k, j)
            k = j
        }
    }
    
}
