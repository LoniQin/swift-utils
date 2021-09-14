//
//  AcyclicLongestPath.swift
//  
//
//  Created by Lonnie on 2020/12/25.
//

import Foundation
public class AcyclicLongestPath {
    
    private var distTo: [Double]
    
    private var edgeTo: [DirectedEdge?]
    
    private let graph: EdgeWeightedDigraph
    
    public init(_ graph: EdgeWeightedDigraph, _ s: Int) throws {
        self.graph = graph
        distTo = [Double](repeating: -.infinity, count: graph.vertexCount)
        distTo[s] = 0
        edgeTo = [DirectedEdge?](repeating: nil, count: graph.vertexCount)
        try validateVertex(s)
    }
    
    private func validateVertex(_ v: Int) throws {
        if v < 0 || v >= distTo.count {
            throw FoundationError.outOfBounds
        }
    }
    
    public func start() throws {
        let topological = TopologicalSort(graph.toDigraph())
        guard let order = topological.order else {
            throw FoundationError.message("Digraph is not acyclic.")
        }
        for v in order {
            for e in graph.adj(v) {
                relax(e)
            }
        }
    }
    
    private func relax(_ e: DirectedEdge) {
        if distTo[e.to] < distTo[e.from] + e.weight {
            distTo[e.to] = distTo[e.from] + e.weight
            edgeTo[e.to] = e
        }
    }
    
    public func distTo(_ v: Int) throws -> Double {
        try validateVertex(v)
        return distTo[v]
    }
    
    public func hasPathTo(_ v: Int) throws -> Bool {
        return try distTo(v) > -.infinity
    }
    
    public func pathTo(_ v: Int) throws -> Stack<DirectedEdge>? {
        try validateVertex(v)
        if try !hasPathTo(v) { return nil }
        let path = Stack<DirectedEdge>()
        var i = v
        while let e = edgeTo[i] {
            path.push(e)
            i = e.from
        }
        return path
    }
    
}
