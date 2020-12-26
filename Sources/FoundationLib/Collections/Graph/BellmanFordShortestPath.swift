//
//  BellmanFordShortestPath.swift
//  
//
//  Created by Lonnie on 2020/12/26.
//

import Foundation
public class BellmanFordShortestPath {
    
    private static let EPSILON = 1e-14
    
    private var distTo: [Double]
    
    private var edgeTo: [DirectedEdge?]
    
    private var onQueue: [Bool]
    
    private var queue: Queue<Int>
    
    private var cost: Int
    
    public var negativeCycle: Stack<DirectedEdge>?
    
    private let graph: EdgeWeightedDigraph
    
    public init(_ graph: EdgeWeightedDigraph, _ s: Int) {
        self.graph = graph
        self.cost = 0
        distTo = .init(repeating: .infinity, count: graph.vertexCount)
        edgeTo = .init(repeating: nil, count: graph.vertexCount)
        onQueue = .init(repeating: false, count: graph.vertexCount)
        distTo[s] = 0
        queue = Queue<Int>()
        queue.enqueue(s)
        onQueue[s] = true
    }
    
    public func start() throws {
        while !queue.isEmpty &&  !hasNegativeCycle() {
            let v = try queue.dequeue()
            onQueue[v] = false
            relax(v)
        }
    }
    
    private func relax(_ v: Int) {
        for e in graph.adj(v) {
            let w = e.to
            if distTo[w] > distTo[v] + e.weight + Self.EPSILON {
                distTo[w] = distTo[v] + e.weight
                edgeTo[w] = e
                if !onQueue[w] {
                    queue.enqueue(w)
                    onQueue[w] = true
                }
            }
            if cost.increasing() % graph.vertexCount == 0 {
                findNegativeCycle()
                if hasNegativeCycle() { return }
            }
        }
    }
    
    public func hasNegativeCycle() -> Bool {
        negativeCycle != nil
    }
    
    func findNegativeCycle() {
        let spt = EdgeWeightedDigraph(graph.vertexCount)
        for v in 0..<graph.vertexCount {
            if let e = edgeTo[v] {
                spt.add(e)
            }
        }
        let finder = EdgeWeightedDirectedCycle(spt)
        negativeCycle = finder.cycle
    }
    
    public func distTo(_ v: Int) -> Double {
        distTo[v]
    }
    
    public func hasPathTo(_ v: Int) -> Bool {
        distTo[v] < .infinity
    }
    
    public func pathTo(_ v: Int) -> Stack<DirectedEdge>? {
        if hasNegativeCycle() || !hasPathTo(v) { return nil }
        let path = Stack<DirectedEdge>()
        var i = v
        while let e = edgeTo[i] {
            path.push(e)
            i = e.from
        }
        return path
    }
}
