//
//  DirectedGraph.swift
//  
//
//  Created by lonnie on 2020/10/17.
//

import Foundation
class DirectedGraph: GraphProtocol {
    
    let vertexCount: Int
    
    fileprivate(set) var edgeCount: Int
    
    fileprivate(set) var adj: [[Int]]
    
    var indegree: [Int]
    
    required init(_ vertexCount: Int) {
        self.vertexCount = vertexCount
        self.edgeCount = 0
        indegree = [Int](repeating: 0, count: vertexCount)
        adj = [[Int]](repeating: [], count: vertexCount)
    }
    
    func addEdge(_ v: Int, _ w: Int) {
        if validateVertex(v) && validateVertex(w) {
            adj[v].append(w)
            indegree[w] += 1
            edgeCount += 1
        }
    }
    
    func outdegree(_ v: Int) -> Int {
        if validateVertex(v){ return adj[v].count }
        return -1
    }
    
    func indegree(_ v: Int) -> Int {
        if validateVertex(v){ return indegree[v] }
        return -1
    }
    
    func reversed() -> DirectedGraph {
        let graph = DirectedGraph(vertexCount)
        for v in 0..<vertexCount {
            for w in adj[v] {
                graph.addEdge(w, v)
            }
        }
        return graph
    }
    
}
