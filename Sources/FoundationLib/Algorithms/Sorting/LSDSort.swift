//
//  LSDSort.swift
//  
//
//  Created by Lonnie on 2020/12/30.
//

import Foundation
public class LSDSort {
    
    public init() {
        
    }
    
    public func sort(_ a: inout [String]) throws {
        if a.isEmpty { return }
        let w = a[0].count
        for item in a {
            if item.count != w { throw FoundationError.message("Length of strings should be equal. ") }
        }
        let n = a.count
        let R = 256
        var aux = [String](repeating: "", count: n)
        var d = w - 1
        while d >= 0 {
            var count = [Int](repeating: 0, count: R + 1)
            for i in 0..<n {
                count[Int(a[i].charAt(d).asciiValue! + 1)] += 1
            }
            for r in 0..<R {
                count[r + 1] += count[r]
            }
            for i in 0..<n {
                aux[count[Int(a[i].charAt(d).asciiValue!)]] = a[i]
                count[Int(a[i].charAt(d).asciiValue!)] += 1
            }
            for i in 0..<n {
                a[i] = aux[i]
            }
            d -= 1
        }
    }
    
    public func sort(_ a: inout [Int]) {
        let BITS_PER_BYTE = 8
        let BITS = MemoryLayout<Int>.size * BITS_PER_BYTE
        let R = 1 << BITS_PER_BYTE
        let HALF_R = R >> 1
        let MASK = R - 1
        let w = BITS / BITS_PER_BYTE
        let n = a.count
        var aux = [Int](repeating: 0, count: n)
        var c = 0, shift1 = 0, shift2 = 0
        for d in 0..<w {
            var count = [Int](repeating: 0, count: R + 1)
            for i in 0..<n {
                c = (a[i] >> (BITS_PER_BYTE * d)) & MASK
                count[c + 1] += 1
            }
            for r in 0..<R {
                count[r + 1] += count[r]
            }
            if d == w - 1 {
                shift1 = count[R] - count[HALF_R]
                shift2 = count[HALF_R]
                for r in 0..<HALF_R {
                    count[r] += shift1
                }
                for r in HALF_R..<R {
                    count[r] -= shift2
                }
            }
            for i in 0..<n {
                c = (a[i] >> (BITS_PER_BYTE * d)) & MASK
                aux[count[c]] = a[i]
                count[c] += 1
            }
            for i in 0..<n {
                a[i] = aux[i]
            }
        }
    }
    
}
