//
//  GraphCycleFinder.swift
//  
//
//  Created by lonnie on 2020/11/14.
//

import Foundation
public class GraphCycleFinder<G: GraphProtocol> {
    
    var marked: [Bool]
    
    var edgeTo: [Int]
    
    public var cycle: Stack<Int>?
    
    var onStack: [Bool]
    
    public init(_ graph: G) {
        onStack = [Bool](repeating: false, count: graph.vertexCount)
        edgeTo = [Int](repeating: 0, count: graph.vertexCount)
        marked = [Bool](repeating: false, count: graph.vertexCount)
        for v in 0..<graph.vertexCount {
            if !marked[v] && cycle == nil {
                dfs(graph, v)
            }
        }
    }
    
    func dfs(_ graph: G, _ v: Int) {
        onStack[v] = true
        marked[v] = true
        for w in graph.adj(v) {
            if hasCycle() { return }
            else if !marked[w] {
                edgeTo[w] = v
                dfs(graph, w)
            } else if onStack[w] {
                cycle = Stack<Int>()
                var x = v
                while x != w {
                    cycle?.push(x)
                    x = edgeTo[x]
                }
                cycle?.push(w)
                cycle?.push(v)
            }
        }
        onStack[v] = false
    }
    
    func hasCycle() ->Bool {
        cycle != nil
    }
    
}
