//
//  EdgeWeightedDigraph.swift
//  
//
//  Created by Lonnie on 2020/12/25.
//

import Foundation

public final class EdgeWeightedDigraph {
    
    public let vertexCount: Int
    
    public fileprivate(set) var edgeCount: Int
    
    public fileprivate(set) var adj: [Bag<DirectedEdge>]
    
    private var indegree: [Int]
    
    public init(_ vertexCount: Int) {
        self.vertexCount = vertexCount
        self.edgeCount = 0
        indegree = [Int](repeating: 0, count: vertexCount)
        adj = []
        for _ in 0..<vertexCount {
            adj.append(Bag<DirectedEdge>())
        }
    }
    
    public func add(_ e: DirectedEdge) {
        adj[e.from].add(e)
        indegree[e.to] += 1
        edgeCount += 1
    }
    
    public func adj(_ i: Int) -> Bag<DirectedEdge> {
        adj[i]
    }
    
    public func outdegree(_ v: Int) -> Int {
        adj[v].count
    }
    
    public func indegree(_ v: Int) -> Int {
        indegree[v]
    }
    
    public func edges() -> Bag<DirectedEdge> {
        let list = Bag<DirectedEdge>()
        for v in 0..<vertexCount {
            for e in adj(v) {
                list.add(e)
            }
        }
        return list
    }
    
}

extension EdgeWeightedDigraph: StringConvertable {
    public static func fromString(_ string: String) throws -> EdgeWeightedDigraph {
        var index = 0
        var vertextCount = 0
        var graph: EdgeWeightedDigraph?
        var error: Error?
        string.enumerateLines { (line, stop) in
            do {
                if index == 0 {
                    vertextCount = Int(line).unwrapped
                    graph = EdgeWeightedDigraph(vertextCount)
                }
                if index >= 2 {
                    let components = line.components(separatedBy: " ")
                    guard
                        components.count == 3,
                        let v = Int(components[0]),
                        let w = Int(components[1]),
                        let weight = Double(components[2])
                        else {
                        throw FoundationError.invalidCoding
                    }
                    graph?.add(DirectedEdge(v, w, weight))
                }
                index += 1
            } catch let e {
                error = e
            }
        }
        if let error = error {
            throw error
        }
        guard graph != nil else {
            throw FoundationError.nilValue
        }
        return graph!
    }
    
    public func toString() -> String {
        var s = ""
        s.append("\(vertexCount)\n")
        s.append("\(edgeCount)\n")
        for v in 0..<vertexCount {
            for edge in adj[v] {
                if edge.from == v {
                    s.append("\(edge.from) \(edge.to) \(edge.weight)\n")
                }
            }
        }
        return s
    }
}
