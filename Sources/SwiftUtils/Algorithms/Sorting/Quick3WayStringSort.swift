//
//  Quick3WayStringSort.swift
//  
//
//  Created by Lonnie on 2020/12/31.
//

import Foundation
public class Quick3WayStringSort {
    
    static let CUTOFF =  15
    
    public init() {
        
    }
    
    public func sort(_ a: inout [String]) {
        a.shuffle()
        sort(&a, 0, a.count - 1, 0)
    }
    
    private func sort(_ a: inout [String], _ lo: Int, _ hi: Int, _ d: Int) {
        guard hi > lo + Self.CUTOFF else {
            insertion(&a, lo, hi, d)
            return
        }
        var lt = lo, gt = hi
        let v = chatAt(a[lo], d)
        var i = lo + 1
        while i <= gt {
            let t = chatAt(a[i], d)
            if t < v {
                a.swapAt(lt, i)
                lt += 1
                i += 1
            } else if t > v {
                a.swapAt(i, gt)
                gt -= 1
            } else {
                i += 1
            }
        }
        sort(&a, lo, lt - 1, d)
        if v >= 0 {
            sort(&a, lt, gt, d + 1)
        }
        sort(&a, gt + 1, hi, d)
    }
    
    private func insertion(_ a: inout [String], _ lo: Int, _ hi: Int, _ d: Int) {
        if lo > hi { return }
        for i in lo...hi {
            var j = i
            while j > lo && less(a[j], a[j - 1], d)  {
                a.swapAt(j, j - 1)
                j -= 1
            }
        }
    }
    
    private func less(_ v: String, _ w: String, _ d: Int) -> Bool {
        let hi = min(v.count, w.count)
        if d > hi { return v < w }
        for i in d..<hi {
            if v.charAt(i) < w.charAt(i) { return true }
            if v.charAt(i) > w.charAt(i) { return false }
        }
        return v.count < w.count
    }
    
    private func chatAt(_ s: String, _ d: Int) -> Int {
        d == s.count ? -1 : Int(s.charAt(d).asciiValue!)
    }
    
}
