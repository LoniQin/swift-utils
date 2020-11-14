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
    
    public struct Edge {
        public var from: Int
        public var to: Int
    }
    
    let graph: T
    
    var marked: [Bool]
    
    var method: Method
    
    var block: (Edge)->Void
    
    let items: [Int]
    
    public init(
        _ graph: T,
        _ method: Method,
        _ items: [Int],
        _ block: @escaping (Edge)->Void = { item in }) {
        marked = [Bool](repeating: false, count: graph.vertexCount)
        self.method = method
        self.block = block
        self.graph = graph
        self.items = items
    }
    
    func begin() {
        if method == .bfs {
            bfs(graph, items)
        } else {
            dfs(graph, items)
        }
    }
    
    func dfs(_ graph: T, _ items: [Int]) {
        for item in items {
            if marked[item] { continue }
            let stack = Stack<Edge>()
            stack.push(Edge(from: -1, to: item))
            while !stack.isEmpty {
                let v = try! stack.pop()
                if marked[v.to] { continue }
                marked[v.to] = true
                block(v)
                for w in graph.adj[v.to].reversed() {
                    if !marked[w] {
                        stack.push(Edge(from: v.to, to: w))
                    }
                }
            }

        }
    }
    
    func bfs(_ graph: T, _ items: [Int]) {
        let queue = Queue<Edge>()
        for item in items {
            queue.enqueue(Edge(from: -1, to: item))
        }
        while !queue.isEmpty {
            let v = try! queue.dequeue()
            if marked[v.to] { continue }
            marked[v.to] = true
            block(v)
            for item in graph.adj(v.to) {
                if !marked[item] { queue.enqueue(Edge(from: v.to, to: item)) }
            }
        }
    }
    
    public func visited(_ w: Int) -> Bool {
        marked[w]
    }
    
}
