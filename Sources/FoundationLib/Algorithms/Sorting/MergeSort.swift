//
//  MergeSort.swift
//  
//
//  Created by lonnie on 2020/11/16.
//

import Foundation
public class MergeSort<Element> {
    
    public init() { }
    
    @discardableResult
    public func sort(_ items: inout [Element], _ comparator: @escaping (Element, Element) -> Bool) -> [Element] {
        var aux = [Element](repeating: items[0], count: items.count)
        sort(&items, &aux, 0, items.count - 1, comparator)
        return items
    }
    
    func sort(_ items: inout [Element], _ aux: inout [Element], _ lo: Int, _ hi: Int, _ comparator: @escaping (Element, Element) -> Bool) {
       if hi <= lo { return }
        let mid = lo + (hi - lo) / 2
        sort(&items, &aux, lo, mid, comparator)
        sort(&items, &aux, mid + 1, hi, comparator)
        merge(&items, &aux, lo, mid, hi, comparator)
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
