//
//  EdgeWeightedDirectedCycle.swift
//  
//
//  Created by Lonnie on 2020/12/26.
//

import Foundation
public class EdgeWeightedDirectedCycle {
    
    private var marked: [Bool]
    
    private var edgeTo: [DirectedEdge?]
    
    private var onStack: [Bool]
    
    public fileprivate(set) var cycle: Stack<DirectedEdge>?
    
    private let graph: EdgeWeightedDigraph
    
    public init(_ graph: EdgeWeightedDigraph) {
        self.graph = graph
        onStack = .init(repeating: false, count: graph.vertexCount)
        marked = .init(repeating: false, count: graph.vertexCount)
        edgeTo = .init(repeating: nil, count: graph.vertexCount)
        for v in 0..<graph.vertexCount {
            if !marked[v] {
                dfs(graph, v)
            }
        }
    }
    
    private func dfs(_ g: EdgeWeightedDigraph, _ v: Int) {
        onStack[v] = true
        marked[v] = true
        for e in g.adj[v] {
            let w = e.to
            if cycle != nil { return  }
            else if !marked[w] {
                edgeTo[w] = e
                dfs(g, w)
            } else if onStack[w] {
                cycle = Stack<DirectedEdge>()
                var f = e
                while f.from != w {
                    cycle?.push(f)
                    f = edgeTo[f.from]!
                }
                cycle?.push(f)
            }
        }
        onStack[v] = false
    }
    
    public func hasCycle() -> Bool {
        cycle != nil
    }

}
