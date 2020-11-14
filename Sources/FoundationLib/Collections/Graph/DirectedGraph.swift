//
//  DirectedGraph.swift
//  
//
//  Created by lonnie on 2020/10/17.
//

import Foundation
public class DirectedGraph: GraphProtocol {
    
    public let vertexCount: Int
    
    public fileprivate(set) var edgeCount: Int
    
    public fileprivate(set) var adj: [Bag<Int>]
    
    public var indegree: [Int]
    
    public required init(_ vertexCount: Int) {
        self.vertexCount = vertexCount
        self.edgeCount = 0
        indegree = [Int](repeating: 0, count: vertexCount)
        adj = []
        for _ in 0..<vertexCount {
            adj.append(Bag<Int>())
        }
    }
    
    public func addEdge(_ v: Int, _ w: Int) {
        if validateVertex(v) && validateVertex(w) {
            adj[v].add(w)
            indegree[w] += 1
            edgeCount += 1
        }
    }
    
    public func outdegree(_ v: Int) -> Int {
        if validateVertex(v){ return adj[v].count }
        return -1
    }
    
    public func indegree(_ v: Int) -> Int {
        if validateVertex(v){ return indegree[v] }
        return -1
    }
    
    public func reversed() -> DirectedGraph {
        let graph = DirectedGraph(vertexCount)
        for v in 0..<vertexCount {
            for w in adj[v] {
                graph.addEdge(w, v)
            }
        }
        return graph
    }
    
}
