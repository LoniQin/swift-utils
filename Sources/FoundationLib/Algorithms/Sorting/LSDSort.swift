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
    
    public func sort(_ a: inout [Int]) {
        let BITS_PER_BYTE = 8
        let BITS = 64
        let R = 1 << BITS_PER_BYTE
        let MASK = R - 1
        let w = BITS / BITS_PER_BYTE
        let n = a.count
        var aux = [Int](repeating: 0, count: n)
        for d in 0..<w {
            var count = [Int](repeating: 0, count: R + 1)
            for i in 0..<n {
                let c = (a[i] >> (BITS_PER_BYTE * d)) & MASK
                count[c + 1] += 1
            }
            for r in 0..<R {
                count[r + 1] += count[r]
            }
            if d == w - 1 {
                let shift1 = count[R] - count[R / 2]
                let shift2 = count[R / 2]
                for r in 0..<R / 2 {
                    count[r] += shift1
                }
                for r in R / 2..<R {
                    count[r] -= shift2
                }
            }
            for i in 0..<n {
                let c = (a[i] >> (BITS_PER_BYTE * d)) & MASK
                aux[count[c]] = a[i]
                count[c] += 1
            }
            for i in 0..<n {
                a[i] = aux[i]
            }
        }
    }
    
}
