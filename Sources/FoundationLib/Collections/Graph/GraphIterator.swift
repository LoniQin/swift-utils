//
//  GraphIterator.swift
//  
//
//  Created by lonnie on 2020/11/14.
//

import Foundation
public class GraphIterator<T: GraphProtocol> {
    
    public enum Method {
        
        case bfs
        
        case dfs
        
    }
    
    var marked: [Bool]
    
    var block: ((Int, Int))->Void
    
    public init(
        _ graph: T,
        _ method: Method,
        _ items: [Int],
        _ block: @escaping ((Int, Int))->Void = { item in }) {
        marked = [Bool](repeating: false, count: graph.vertexCount)
        self.block = block
        if method == .bfs {
            bfs(graph, items)
        } else {
            dfs(graph, items)
        }
    }
    
    func dfs(_ graph: T, _ items: [Int]) {
        for item in items {
            if marked[item] { continue }
            let stack = Stack<(Int, Int)>()
            stack.push((-1, item))
            while !stack.isEmpty {
                let v = try! stack.pop()
                if marked[v.1] { continue }
                marked[v.1] = true
                block(v)
                for w in graph.adj[v.1].reversed() {
                    if !marked[w] {
                        stack.push((v.1, w))
                    }
                }
            }

        }
    }
    
    func bfs(_ graph: T, _ items: [Int]) {
        let queue = Queue<(Int, Int)>()
        for item in items {
            queue.enqueue((-1, item))
        }
        while !queue.isEmpty {
            let v = try! queue.dequeue()
            if marked[v.1] { continue }
            marked[v.1] = true
            block(v)
            for item in graph.adj(v.1) {
                if !marked[item] { queue.enqueue((v.1, item)) }
            }
        }
    }
    
    public func visited(_ w: Int) -> Bool {
        marked[w]
    }
    
}
