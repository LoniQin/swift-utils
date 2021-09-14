//
//  KosarajuSharirSCC.swift
//
//
//  Created by lonnie on 2020/11/17.
//

import Foundation
public class KosarajuSharirSCC {
    
    private var marked: [Bool]
    
    public fileprivate(set) var id: [Int]
    
    public fileprivate(set) var count: Int = 0
    
    let graph: DirectedGraph
    
    public init(_ graph: DirectedGraph) {
        self.graph = graph
        marked = .init(repeating: false, count: graph.vertexCount)
        id = .init(repeating: 0, count: graph.vertexCount)
    }
    
    public func start() {
        let dfs = GraphDepthFirstOrder(graph.reversed())
        for v in dfs.reversePostOrder {
            if !marked[v] {
                self.dfs(graph, v)
                count += 1
            }
        }
    }
    
    public func stronglyConnected(_ v: Int, _ w: Int) -> Bool {
        id[v] == id[w]
    }
    
    
    func dfs(_ g: DirectedGraph, _ v: Int) {
        marked[v] = true
        id[v] = count
        for w in g.adj(v) {
            if !marked[w] {
                dfs(g, w)
            }
        }
    }
}
