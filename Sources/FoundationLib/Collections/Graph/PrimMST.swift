//
//  PrimMST.swift
//  
//
//  Created by Lonnie on 2020/12/25.
//

import Foundation
public class PrimMST {
    
    private var edgeTo: [Edge?]
    
    private var distTo: [Double]
    
    private var marked: [Bool]
    
    private var priorityQueue: IndexMinPriorityQueue<Double>
    
    private let graph: EdgeWeightedGraph
    
    public init(_ graph: EdgeWeightedGraph) {
        self.graph = graph
        edgeTo = [Edge?](repeating: nil, count: graph.vertexCount)
        distTo = [Double](repeating: .infinity, count: graph.vertexCount)
        marked = [Bool](repeating: false, count: graph.vertexCount)
        priorityQueue = IndexMinPriorityQueue(graph.vertexCount)
    }
    
    public func start() throws {
        for v in 0..<graph.vertexCount {
            if !marked[v] {
                try prim(v)
            }
        }
    }
    
    private func prim(_ s: Int) throws {
        distTo[s] = 0
        priorityQueue.insert(s, distTo[s])
        while !priorityQueue.isEmpty {
            let index = priorityQueue.deleteMin()
            try scan(index)
        }
    }
    
    private func scan(_ v: Int) throws {
        if v < 0 { return }
        marked[v] = true
        for e in graph.adj(v) {
            let w = try e.other(v)
            if marked[w] { continue }
            if e.weight < distTo[w] {
                distTo[w] = e.weight
                edgeTo[w] = e
                if priorityQueue.contains(w) {
                    priorityQueue.changeKey(w, distTo[w])
                } else {
                    priorityQueue.insert(w, distTo[w])
                }
            }
        }
    }
    
    public func edges() -> Queue<Edge> {
        let mst = Queue<Edge>()
        for v in 0..<edgeTo.count {
            if let e = edgeTo[v] {
                mst.enqueue(e)
            }
        }
        return mst
    }
    
    var weight: Double {
        var weight = 0.0
        for e in edges() {
            weight += e.weight
        }
        return weight
    }

    
}
