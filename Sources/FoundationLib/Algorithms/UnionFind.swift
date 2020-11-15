//
//  UnionFind.swift
//  
//
//  Created by lonnie on 2020/11/15.
//

import Foundation
public class UnionFind {
    
    private var id: [Int]
    
    public var count: Int
    
    public init(_ count: Int) {
        self.count = count
        id = (0..<count).map { $0 }
    }
    
    public func connected(_ p: Int, _ q: Int) -> Bool {
        id[p] == id[q]
    }
    
    public func union(_ p: Int, _ q: Int) {
        let pid = id[p]
        let qid = id[q]
        for i in 0..<id.count {
            if id[i] == pid {
                id[i] = qid
            }
        }
    }
    
}
