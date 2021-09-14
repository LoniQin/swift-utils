//
//  LazyPrimMST.swift
//  
//
//  Created by Lonnie on 2020/12/25.
//

import Foundation
public class LazyPrimMST {
    
    public fileprivate(set) var weight: Double
    
    public fileprivate(set) var mst: Queue<Edge>
    
    public fileprivate(set) var marked: [Bool]
    
    private var priorityQueue: PriorityQueue<Edge>
    
    private var graph: EdgeWeightedGraph
    
    public init(_ graph: EdgeWeightedGraph) {
        weight = 0
        mst = Queue<Edge>()
        priorityQueue = PriorityQueue<Edge>(comparator: { $0.weight > $1.weight })
        marked = [Bool](repeating: false, count: graph.vertexCount)
        self.graph = graph
    }
    
    func start() {
        for v in 0..<graph.vertexCount {
            if !marked[v] {
                prim(v)
            }
        }
    }
    
    private func prim(_ s: Int) {
        scan(s)
        while !priorityQueue.isEmpty {
            let edge = priorityQueue.deleteTop()!
            let v = edge.v
            let w = edge.w
            assert(marked[v] || marked[w])
            if marked[v] && marked[w] { continue }
            mst.enqueue(edge)
            weight += edge.weight
            if !marked[v] { scan(v) }
            if !marked[w] { scan(w) }
        }
    }
    
    private func scan(_ v: Int) {
        assert(!marked[v])
        marked[v] = true
        for e in graph.adj(v) {
            if !marked[try! e.other(v)] {
                priorityQueue.insert(e)
            }
        }
    }
    
    public func edges() -> Queue<Edge> {
        mst
    }
    
}
