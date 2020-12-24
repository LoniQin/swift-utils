//
//  EdgeWeightedGraph.swift
//  
//
//  Created by Lonnie on 2020/12/25.
//

import Foundation
public final class EdgeWeightedGraph {
    
    let vertexCount: Int
    
    public fileprivate(set) var edgeCount: Int
    
    public fileprivate(set) var adj: [Bag<Edge>]
    
    public init(_ vertexCount: Int) {
        self.vertexCount = vertexCount
        self.edgeCount = 0
        adj = [Bag<Edge>]()
        for _ in 0..<vertexCount {
            adj.append(Bag<Edge>())
        }
    }
    
    private func validateVertex(_ v: Int) throws {
        if v < 0 || v >= vertexCount {
            throw FoundationError.message("vertext \(v) is not between 0 and \(vertexCount - 1)")
        }
    }
    
    public func add(_ edge: Edge) throws {
        try validateVertex(edge.v)
        try validateVertex(edge.w)
        adj[edge.v].add(edge)
        adj[edge.w].add(edge)
        edgeCount += 1
    }
    
    public func adj(_ v: Int) -> Bag<Edge> {
        do {
            try validateVertex(v)
            return adj[v]
        } catch {
            return Bag<Edge>()
        }
    }
    
    public func degree(_ v: Int) -> Int {
        adj[v].count
    }
    
    func edges() -> Bag<Edge> {
        do {
            let list = Bag<Edge>()
            for v in 0..<vertexCount {
                var selfLoops = 0
                for e in adj[v] {
                    if try e.other(v) > v {
                        list.add(e)
                    } else if try e.other(v) == v {
                        if selfLoops % 2 == 0 { list.add(e) }
                        selfLoops += 1
                    }
                }
            }
            return list
        } catch {
            return Bag<Edge>()
        }
    }
    
}


extension EdgeWeightedGraph: StringConvertable {
    public static func fromString(_ string: String) throws -> EdgeWeightedGraph {
        var index = 0
        var vertextCount = 0
        var graph: EdgeWeightedGraph?
        var error: Error?
        string.enumerateLines { (line, stop) in
            do {
                if index == 0 {
                    vertextCount = Int(line).unwrapped
                    graph = EdgeWeightedGraph(vertextCount)
                }
                if index >= 2 && !line.isEmpty {
                    let components = line.components(separatedBy: " ")
                    if components.count != 3 {
                        throw FoundationError.invalidCoding
                    }
                    guard
                        let v = Int(components[0]),
                        let w = Int(components[1]),
                        let weight = Double(components[2])
                        else {
                        throw FoundationError.invalidCoding
                    }
                    try graph?.add(Edge(v, w, weight))
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
                if edge.v < edge.w {
                    s.append("\(edge.v) \(edge.w) \(edge.weight)\n")
                }
            }
        }
        return s
    }
}
