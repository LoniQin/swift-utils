//
//  Array+Sorting.swift
//  
//
//  Created by lonnie on 2020/10/12.
//

import Foundation
public extension Array where Element: Comparable & Hashable {
    
    mutating func sort(algorithm: SortingAlgorithm, by comparator: @escaping (Element, Element) -> Bool = { $0 < $1 }) {
        switch algorithm {
        case .native:
            sort(by: comparator)
        case .shell:
            shellSort(by: comparator)
        case .quick:
            quickSort(by: comparator)
        case .quick3Way:
            quick3WaySort(by: comparator)
        case .heap:
            heapSort(by: comparator)
        case .bucket:
            bucketSort(by: comparator)
        case .selection:
            selectionSort(by: comparator)
        case .insertion:
            insertionSort(by: comparator)
        case .merge:
            mergeSort(by: comparator)
        }
    }
    
    func sorted(algorithm: SortingAlgorithm, by comparator: @escaping (Element, Element) -> Bool = { $0 < $1 }) -> Self {
        var value = self
        value.sort(algorithm: algorithm, by: comparator)
        return value
    }
    
    mutating func shellSort(by comparator: @escaping (Element, Element) -> Bool = { $0 < $1 }) {
        let n = count
        var h = 1
        while h < n / 3 { h = 3 * h + 1 }
        while h >= 1 {
            for i in h..<n {
                var j = i
                repeat {
                    if comparator(self[j], self[j - h]) {
                        swapAt(j, j - h)
                    }
                    j -= h
                } while j >= h
            }
            h /= 3
        }
    }
    
    mutating func quickSort(by comparator: @escaping (Element, Element) -> Bool = { $0 < $1 }) {
        quickSort(low: 0, high: count - 1)
    }
    
    
    mutating func quick3WaySort(by comparator: @escaping (Element, Element) -> Bool = { $0 < $1 }) {
        quick3WaySort(low: 0, high: count - 1, by: comparator)
    }
    
    mutating func heapSort(by comparator: @escaping (Element, Element) -> Bool = { $0 < $1 }) {
        var n = count
        var k = n >> 1
        while k >= 1 {
            sink(k, n, by: comparator)
            k -= 1
        }
        while n > 1 {
            swapAt(0, n - 1)
            n -= 1
            sink(1, n, by: comparator)
        }
    }
    
    mutating func bucketSort(by comparator: @escaping (Element, Element) -> Bool = { $0 < $1 }) {
        var counter: [Element: Int] = [:]
        for item in self {
            counter[item] = (counter[item] ?? 0) + 1
        }
        let keys = counter.keys.sorted(by: comparator)
        var i = 0
        for key in keys {
            let count = counter[key] ?? 0
            for _ in 0..<count {
                self[i] = key
                i += 1
            }
        }
    }
    
    mutating func selectionSort(by comparator: @escaping (Element, Element) -> Bool = { $0 < $1 }) {
        for i in 0..<count {
            var index = i
            for j in i+1..<count {
                if comparator(self[j], self[index]) {
                    index = j
                }
            }
            swapAt(index, i)
        }
    }
    
    mutating func insertionSort(by comparator: @escaping (Element, Element) -> Bool = { $0 < $1 }) {
        for i in 1..<count {
            var j = i
            while j > 0 {
                if comparator(self[j], self[j - 1]) {
                    swapAt(j, j - 1)
                }
                j -= 1
            }
        }
    }
    
    mutating func mergeSort(by comparator: @escaping (Element, Element) -> Bool = { $0 < $1 }) {
        let merge = BottomUpMergeSort<Element>()
        merge.sort(&self, comparator)
    }
    
}

public extension Array where Element: Comparable & Hashable {
    mutating func sort(algorithm: SortingAlgorithm) {
        sort(algorithm: algorithm, by: <)
    }
    
    func sorted(algorithm: SortingAlgorithm) -> Self {
        sorted(by: <)
    }
}

extension Array where Element: Comparable {
    
    mutating func quickSort(low: Int, high: Int, by comparator: @escaping (Element, Element) -> Bool = { $0 < $1 }) {
        if high <= low { return }
        let j = partition(low: low, high:high, by: comparator)
        quickSort(low: low, high: j - 1, by: comparator)
        quickSort(low: j + 1, high: high, by: comparator)
    }

    mutating func partition(low: Int, high: Int, by comparator: @escaping (Element, Element) -> Bool = { $0 < $1 }) -> Int {
        var i = low
        var j = high + 1
        let v = self[low]
        while true {
            while comparator(self[i.increasing()], v) && i != high {}
            while comparator(v, self[j.decreasing()]) && i != low {}
            if i >= j { break }
            swapAt(i, j)
        }
        swapAt(low, j)
        return j
    }
    
    mutating func quick3WaySort(low: Int, high: Int, by comparator: @escaping (Element, Element) -> Bool = { $0 < $1 }) {
        if high <= low { return }
        var lt = low, gt = high
        let v = self[low]
        var i = low + 1
        while i <= gt {
            if self[i] == v {
                i += 1
                continue
            }
            if comparator(self[i], v) {
                swapAt(lt, i)
                lt += 1
                i += 1
            } else {
                swapAt(i, gt)
                gt -= 1
            }
        }
        quick3WaySort(low: low, high: lt - 1, by: comparator)
        quick3WaySort(low: gt + 1, high: high, by: comparator)
    }
    
    mutating func sink(_ k: Int, _ n: Int, by comparator: @escaping (Element, Element) -> Bool) {
        var k = k
        while 2 * k <= n {
            var j = 2 * k
            if j < n && comparator(self[j - 1], self[j]) { j += 1 }
            if !comparator(self[k - 1], self[j - 1]) { break }
            swapAt(k - 1, j - 1)
            k = j
        }
    }
    
}
