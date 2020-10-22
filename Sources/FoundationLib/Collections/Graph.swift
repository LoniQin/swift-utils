//
//  Graph.swift
//  
//
//  Created by lonnie on 2020/10/17.
//

class Graph: GraphProtocol {
    
    let vertexCount: Int
    
    fileprivate(set) var edgeCount: Int
    
    fileprivate(set) var adj: [[Int]]
    
    required init(_ v: Int) {
        self.vertexCount = v
        self.edgeCount = 0
        adj = [[Int]](repeating: [], count: v)
    }
    
    func addEdge(_ v: Int, _ w: Int) {
        if !validateVertex(v) || !validateVertex(w) { return }
        edgeCount += 1
        adj[v].append(w)
        adj[w].append(v)
    }
    
    func degree(_ v: Int) -> Int {
        if !validateVertex(v) { return 0 }
        return adj[v].count
    }
    
    func maxDegree() -> Int {
        var maxValue = 0
        for v in 0..<vertexCount {
            maxValue = max(maxValue, degree(v))
        }
        return maxValue
    }
    
}
