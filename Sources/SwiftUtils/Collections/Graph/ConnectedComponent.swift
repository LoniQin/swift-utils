//
//  ConnectedComponent.swift
//  
//
//  Created by lonnie on 2020/11/17.
//

import Foundation
public class ConnectedComponent {
    
    private var marked: [Bool]
    
    public fileprivate(set) var id: [Int]
    
    public fileprivate(set) var count: Int = 0
    
    let graph: Graph
    
    public init(_ graph: Graph) {
        self.graph = graph
        marked = .init(repeating: false, count: graph.vertexCount)
        id = .init(repeating: 0, count: graph.vertexCount)
    }
    
    public func start() {
        for v in 0..<graph.vertexCount {
            if !marked[v] {
                self.dfs(graph, v)
                count += 1
            }
        }
    }
    
    
    func dfs(_ g: Graph, _ v: Int) {
        marked[v] = true
        id[v] = count
        for w in g.adj(v) {
            if !marked[w] {
                dfs(g, w)
            }
        }
    }
}
