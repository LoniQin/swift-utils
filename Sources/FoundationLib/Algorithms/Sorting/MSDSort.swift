//
//  MSDSort.swift
//  
//
//  Created by Lonnie on 2020/12/30.
//

import Foundation
public class MSDSort {
    
    static let BITS_PER_BYTE = 8
    
    static let R = 1 << BITS_PER_BYTE
    
    static let CUTOFF = 15
    
    public init() {
        
    }
    
    public func sort(_ a: inout [String]) throws {
        let count = a.count
        var aux = [String](repeating: "", count: count)
        sort(&a, 0, count - 1, 0, &aux)
    }
    
    private func charAt(_ string: String, _ d: Int) -> Int {
        if d == string.count { return -1 }
        return Int(string.charAt(d).asciiValue!)
    }
    
    private func sort(_ a: inout [String], _ lo: Int, _ hi: Int, _ d: Int, _ aux: inout [String]) {
        guard
            hi > lo + Self.CUTOFF
        else {
            insertion(&a, lo, hi, d)
            return
        }
        var count = [Int](repeating: 0, count: Self.R + 2)
        
        for i in lo...hi {
            let c = charAt(a[i], d)
            count[c + 2] += 1
        }
        
        for r in 0...Self.R {
            count[r + 1] += count[r]
        }
        
        for i in lo...hi {
            let c = charAt(a[i], d)
            aux[count[c + 1]] = a[i]
            count[c + 1] += 1
        }
        
        for i in lo...hi {
            a[i] = aux[i - lo]
        }
        
        for r in 0..<Self.R {
            sort(&a, lo + count[r], lo + count[r + 1] - 1, d + 1, &aux)
        }
        
    }
    
    private func insertion(_ a: inout [String], _ lo: Int, _ hi: Int, _ d: Int) {
        for i in lo...hi {
            var j = i
            while j > lo && less(a[j], a[j - 1], d) {
                a.swapAt(j, j - 1)
                j -= 1
            }
        }
    }
    
    private func less(_ v: String, _ w: String, _ d: Int) -> Bool {
        let upperBound = min(v.count, w.count)
        if d < upperBound {
            for i in d..<upperBound {
                if v.charAt(i) < w.charAt(i) { return true }
                if v.charAt(i) > w.charAt(i) { return false }
            }
        }
        return v.count < w.count
    }
    
}
