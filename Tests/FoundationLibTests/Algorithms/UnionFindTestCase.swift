
//
//  UnionFindTestCase.swift
//
//
//  Created by lonnie on 2020/11/15.
//

import Foundation
import XCTest
@testable import FoundationLib

final class UnionFindTestCase: XCTestCase {
    
    func testUF() {
        class UF {
            var parent: [Int]
            var rank: [Int]
            var count: Int
            
            init(_ count: Int) {
                self.count = count
                parent = (0..<count).map { $0 }
                rank = .init(repeating: 0, count: count)
            }
            
            func find(_ p: Int) -> Int {
                var p = p
                while p != parent[p] {
                    parent[p] = parent[parent[p]]
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
                if rank[rootP] < rank[rootQ] { parent[rootP] = rootQ }
                else if rank[rootP] > rank[rootQ] { parent[rootQ] = rootP }
                else {
                    parent[rootQ] = rootP
                    rank[rootP] += 1
                }
                count -= 1
            }
        }
        download("https://algs4.cs.princeton.edu/15uf/tinyUF.txt") { (t: String) in
            print(t)
            let components = t.components(separatedBy: .newlines).filter { !$0.isEmpty }.map({$0.components(separatedBy: " ")})
            let count = Int(components[0][0]) ?? -1
            if count > 0 {
                print(count)
                let uf = UF(count)
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
    
}
