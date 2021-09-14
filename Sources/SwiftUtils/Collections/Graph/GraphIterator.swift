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
            for item in items {
                dfs(graph, Edge(from: -1, to: item))
            }
        }
    }
    
    func dfs(_ graph: T, _ edge: Edge) {

        var iterators: [Bag<Int>.Iterator] = []
        for i in 0..<graph.vertexCount {
            iterators.append(graph.adj[i].makeIterator())
        }
        let stack = Stack<Edge>()
        marked[edge.to] = true
        stack.push(edge)
        block(edge)
        while !stack.isEmpty {
            let v = try! stack.peek()
            if let item = iterators[v.to].next() {
                let w = item
                if !marked[w] {
                    marked[w] = true
                    let edge = Edge(from: v.to, to: w)
                    block(edge)
                    stack.push(edge)
                }
            } else {
                do {
                    try stack.pop()
                } catch {
                    
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
