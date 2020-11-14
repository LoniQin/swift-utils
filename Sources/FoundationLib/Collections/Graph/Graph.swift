//
//  Graph.swift
//  
//
//  Created by lonnie on 2020/10/17.
//

public class Graph: GraphProtocol {
    
    public let vertexCount: Int
    
    public fileprivate(set) var edgeCount: Int
    
    public fileprivate(set) var adj: [Bag<Int>]
    
    public required init(_ v: Int) {
        self.vertexCount = v
        self.edgeCount = 0
        adj = []
        for _ in 0..<v {
            adj.append(Bag<Int>())
        }
    }
    
    public func addEdge(_ v: Int, _ w: Int) {
        if !validateVertex(v) || !validateVertex(w) { return }
        edgeCount += 1
        adj[v].add(w)
        adj[w].add(v)
    }
    
    public func degree(_ v: Int) -> Int {
        if !validateVertex(v) { return 0 }
        return adj[v].count
    }
    
    public func maxDegree() -> Int {
        var maxValue = 0
        for v in 0..<vertexCount {
            maxValue = max(maxValue, degree(v))
        }
        return maxValue
    }
    
}
