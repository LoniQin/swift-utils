//
//  DijkstraShortestPath.swift
//  
//
//  Created by Lonnie on 2020/12/25.
//

import Foundation

public class DijkstraShortestPath {
    
    private var distTo: [Double]
    
    private var edgeTo: [DirectedEdge?]
    
    private var priorityQueue: IndexMinPriorityQueue<Double>
    
    private let graph: EdgeWeightedDigraph
    
    private let s: Int
    
    public init(_ graph: EdgeWeightedDigraph, _ s: Int) {
        self.graph = graph
        self.s = s
        self.distTo = [Double](repeating: .infinity, count: graph.vertexCount)
        self.edgeTo = [DirectedEdge?](repeating: nil, count: graph.vertexCount)
        self.distTo[s] = 0
        self.priorityQueue = IndexMinPriorityQueue<Double>(graph.vertexCount)
        self.priorityQueue.insert(s, 0)
    }
    
    public func start() {
        while !priorityQueue.isEmpty {
            let v = priorityQueue.deleteMin()
            for e in graph.adj(v) {
                relax(e)
            }
        }
    }
    
    private func relax(_ e: DirectedEdge) {
        if distTo[e.to] > distTo[e.from] + e.weight {
            distTo[e.to] = distTo[e.from] + e.weight
            edgeTo[e.to] = e
            if priorityQueue.contains(e.to) {
                priorityQueue.decreaseKey(e.to, distTo[e.to])
            } else {
                priorityQueue.insert(e.to, distTo[e.to])
            }
        }
    }
    
    public func distTo(_ v: Int) -> Double {
        distTo[v]
    }
    
    public func hasPathTo(_ v: Int) -> Bool {
        distTo[v] < .infinity
    }
    
    public func pathTo(_ v: Int) -> Stack<DirectedEdge>? {
        if !hasPathTo(v) { return nil }
        let path = Stack<DirectedEdge>()
        var e = edgeTo[v]
        while e != nil {
            path.push(e!)
            e = edgeTo[e!.from]
        }
        return path
    }
    
}
