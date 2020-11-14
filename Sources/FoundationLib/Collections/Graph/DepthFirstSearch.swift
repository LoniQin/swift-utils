//
//  DepthFirstSearch.swift
//  
//
//  Created by lonnie on 2020/11/14.
//

import Foundation
public class DepthFirstSearch<T: GraphProtocol> {
    
    var marked: [Bool]
    
    var block: (Int)->Void
    
    public init(_ graph: T, _ start: Int, _ block: @escaping (Int)->Void = { _ in }) {
        marked = [Bool](repeating: false, count: graph.vertexCount)
        self.block = block
        dfs(graph, start)
    }
    
    func dfs(_ graph: T, _ v: Int) {
        marked[v] = true
        block(v)
        for w in graph.adj[v] {
            if !marked[w] {
                dfs(graph, w)
            }
        }
    }
    
    public func visited(_ w: Int) -> Bool {
        marked[w]
    }
    
}
