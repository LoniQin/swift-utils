//
//  PriorityQueue.swift
//  
//
//  Created by lonnie on 2020/10/11.
//

import Foundation
public class PriorityQueue<Element: Equatable>: Countable {
    
    public typealias Comparator = ((Element, Element) -> Bool)
    
    private var pq: [Element?]
    
    public fileprivate(set) var comparator: Comparator
        
    public fileprivate(set) var count = 0
        
    public init(capacity: Int = 1, comparator: @escaping Comparator) {
        pq = [Element?](repeating: nil, count: capacity + 1)
        count = 0
        self.comparator = comparator
    }
        
   public func insert(_ key: Element) {
        if count == pq.count - 1 { resize(pq.count << 1) }
        count += 1
        pq[count] = key
        swim(count)
    }
        
    public func deleteTop() -> Element? {
        if isEmpty { return nil }
        let top = pq[1]
        pq.swapAt(1, count)
        count -= 1
        sink(1)
        pq[count + 1] = nil
        if count > 1 && count == (pq.count - 1) >> 2 { resize(pq.count >> 1) }
        return top
    }
    
    public func delete(_ key: Element){
        if let index = pq.firstIndex(of: key) {
            pq.swapAt(index, count)
            count -= 1
            sink(index)
            pq[count + 1] = nil
            if count > 1 && count == (pq.count - 1) >> 2 { resize(pq.count >> 1) }
        }
    }
    
    public func top() -> Element? {
        return pq[1]
    }
    
    private func swim(_ k: Int) {
        var i = k
        while i > 1 && compare(i >> 1, i) {
            pq.swapAt(i >> 1, i)
            i >>= 1
        }
    }

    private func sink(_ k: Int) {
        var i = k
        while (i << 1) <= count {
            var j = i << 1
            if j < count && compare(j, j + 1) { j += 1 }
            if !compare(i, j) { break }
            pq.swapAt(i, j)
            i = j
        }
    }
    
    private func compare(_ i: Int, _ j: Int) -> Bool {
        return comparator(pq[i]!, pq[j]!)
    }
    
    private func resize(_ capacity: Int) {
        assert(capacity > count)
        for _ in count..<capacity {
            pq.append(nil)
        }
    }
    
}
