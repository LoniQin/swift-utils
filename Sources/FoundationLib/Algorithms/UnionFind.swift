//
//  UnionFind.swift
//  
//
//  Created by lonnie on 2020/11/15.
//

import Foundation
// Weighted quick-union by rank with path compression
public class UnionFind {
    var parent: [Int]
    var rank: [Int]
    var count: Int
    
    public init(_ count: Int) {
        self.count = count
        parent = (0..<count).map { $0 }
        rank = .init(repeating: 0, count: count)
    }
    
    public func find(_ p: Int) -> Int {
        var p = p
        while p != parent[p] {
            parent[p] = parent[parent[p]]
            p = parent[p]
        }
        return p
    }
    
    public func connected(_ p: Int, _ q: Int) -> Bool {
        find(p) == find(q)
    }
    
    public func union(_ p: Int, _ q: Int) {
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
