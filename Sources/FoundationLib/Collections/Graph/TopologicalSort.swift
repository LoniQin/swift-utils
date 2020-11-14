//
//  TopologicalSort.swift
//  
//
//  Created by lonnie on 2020/11/14.
//

import Foundation

public class TopologicalSort<T: GraphProtocol> {
    
    public var order: Stack<Int>?
    
    var rankNum: [Int] = []
    
    public init(_ graph: T) {
        let finder = GraphCycleFinder(graph)
        print(Array(finder.cycle ?? Stack<Int>()))
        if !finder.hasCycle() {
            let dfs = GraphDepthFirstOrder(graph)
            order = dfs.reversePostOrder
            rankNum = [Int](repeating: 0, count: graph.vertexCount)
            var i = 0
            for v in order! {
                rankNum[v] = i
                i += 1
            }
        }
    }
    
    public var hasOrder: Bool {
        order != nil
    }
    
    public var isDAG: Bool {
        hasOrder
    }
    
    public func rank(_ v: Int) -> Int {
        hasOrder ? rankNum[v] : -1
    }
}
