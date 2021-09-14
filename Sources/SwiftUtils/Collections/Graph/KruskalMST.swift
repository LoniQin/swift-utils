//
//  KruskalMST.swift
//  
//
//  Created by Lonnie on 2020/12/25.
//

import Foundation
public class KruskalMST {
    
    public fileprivate(set) var weight: Double
    
    private var mst = Queue<Edge>()
    
    private var priorityQueue = PriorityQueue<Edge>(comparator: >)
    
    private var graph: EdgeWeightedGraph
    
    public init(_ graph: EdgeWeightedGraph) {
        self.weight = 0
        self.graph = graph
    }
    
    public func start() {
        for edge in graph.edges() {
            priorityQueue.insert(edge)
        }
        let uf = UnionFind(graph.vertexCount)
        while !priorityQueue.isEmpty && mst.count < graph.vertexCount {
            if let e = priorityQueue.deleteTop() {
                let v = e.v
                let w = e.w
                if uf.find(v) != uf.find(w) {
                    uf.union(v, w)
                    mst.enqueue(e)
                    weight += e.weight
                }
            }
        }
    }
    
}
