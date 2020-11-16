//
//  BottomUpMergeSort.swift
//  
//
//  Created by lonnie on 2020/11/16.
//

import Foundation
public class BottomUpMergeSort<Element> {
    
    public init() { }
    
    @discardableResult
    public func sort(_ items: inout [Element], _ comparator: @escaping (Element, Element) -> Bool) -> [Element] {
        let n = items.count
        var aux = [Element](repeating: items[0], count: items.count)
        var len = 1
        
        while len < n {
            var lo = 0
            while lo < n - len {
                let mid = lo + len - 1
                let hi = min(lo + len + len - 1, n - 1)
                merge(&items, &aux, lo, mid, hi, comparator)
                lo += len + len
            }
            len *= 2
        }
        return items
    }
    
    func merge(_ items: inout [Element], _ aux: inout [Element], _ lo: Int, _ mid: Int, _ hi: Int, _ comparator: @escaping (Element, Element) -> Bool) {
        for k in lo...hi {
            aux[k] = items[k]
        }
        var i = lo, j = mid + 1
        for k in lo...hi {
            if i > mid {
                items[k] = aux[j]
                j += 1
            } else if j > hi {
                items[k] = aux[i]
                i += 1
            } else if comparator(aux[j], aux[i]) {
                items[k] = aux[j]
                j += 1
            } else {
                items[k] = aux[i]
                i += 1
            }
        }
    }
}
