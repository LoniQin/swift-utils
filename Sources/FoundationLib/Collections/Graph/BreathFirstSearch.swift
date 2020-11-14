//
//  BreathFirstSearch.swift
//  
//
//  Created by lonnie on 2020/11/14.
//

import Foundation
public class BreathFirstSearch<T: GraphProtocol> {
    
    var marked: [Bool]
    
    var block: (Int)->Void
    
    var queue = Queue<Int>()
    
    public init(_ graph: T, _ start: [Int], _ block: @escaping (Int)->Void = { _ in }) throws {
        marked = [Bool](repeating: false, count: graph.vertexCount)
        self.block = block
        try bfs(graph, start)
    }
    
    func bfs(_ graph: T, _ items: [Int]) throws {
        for item in items {
            queue.enqueue(item)
        }
        while !queue.isEmpty {
            let v = try queue.dequeue()
            if marked[v] { continue }
            marked[v] = true
            block(v)
            for item in graph.adj(v) {
                if !marked[item] { queue.enqueue(item) }
            }
        }
    }
    
    public func visited(_ w: Int) -> Bool {
        marked[w]
    }
    
}
