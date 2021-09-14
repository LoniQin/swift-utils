
//
//  UnionFindTestCase.swift
//
//
//  Created by lonnie on 2020/11/15.
//

import Foundation
import XCTest
@testable import SwiftUtils

final class UnionFindTestCase: XCTestCase {
    
    func testUF() {
        
        download("https://algs4.cs.princeton.edu/15uf/tinyUF.txt") { (t: String) in
            print(t)
            let components = t.components(separatedBy: .newlines).filter { !$0.isEmpty }.map({$0.components(separatedBy: " ")})
            let count = Int(components[0][0]) ?? -1
            if count > 0 {
                print(count)
                let uf = UnionFind(count)
                print(components)
                for i in 1..<components.count {
                    if components[i].count != 2 { continue }
                    if let p = Int(components[i][0]), let q = Int(components[i][1]) {
                        uf.union(p, q)
                    }
                    
                }
                uf.count.assert.equal(2)
            }
            
        }

    }
    
    func testFindCircleNumber() {
        class WeightedQuickUnionUF {
            var parent: [Int]
            var size: [Int]
            var count: Int
            
            init(_ count: Int) {
                self.count = count
                parent = (0..<count).map { $0 }
                size = .init(repeating: 1, count: count)
            }
            
            func find(_ p: Int) -> Int {
                var p = p
                while p != parent[p] {
                    p = parent[p]
                }
                return p
            }
            
            func connected(_ p: Int, _ q: Int) -> Bool {
                find(p) == find(q)
            }
            
            func union(_ p: Int, _ q: Int) {
                let rootP = find(p)
                let rootQ = find(q)
                if rootP == rootQ { return }
                if size[rootP] < size[rootQ] {
                    parent[rootP] = rootQ
                    size[rootQ] += size[rootP]
                } else {
                    parent[rootQ] = rootP
                    size[rootP] += size[rootQ]
                }
                count -= 1
            }
        }

        class Solution {
            func findCircleNum(_ M: [[Int]]) -> Int {
                let uf = WeightedQuickUnionUF(M.count)
                for i in 0..<M.count {
                    for j in 0..<M[i].count {
                        if M[i][j] == 1 {
                            uf.union(i, j)
                        }
                    }
                }
                return uf.count
            }
        }
    }
    
}
