//
//  Array+Sorting.swift
//  
//
//  Created by lonnie on 2020/10/12.
//

import Foundation
public extension Array where Element: Comparable {
    mutating func sort(algorithm: SortingAlgorithm, comparator: @escaping (Element, Element) -> Bool = { $0 < $1 }) {
        switch algorithm {
        case .native:
            sort(by: comparator)
        case .shell:
            shellSort(by: comparator)
        case .quick:
            quickSort(by: comparator)
        case .quick3Way:
            quick3WaySort(by: comparator)
        }
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
            if self[i] == v { i += 1 }
            else {
                if comparator(self[i], v) {
                    swapAt(lt, i)
                    lt += 1
                    i += 1
                } else {
                    swapAt(i, gt)
                    gt -= 1
                }
            }
        }
        quick3WaySort(low: low, high: lt - 1, by: comparator)
        quick3WaySort(low: lt + 1, high: high, by: comparator)
    }
    
}
