//
//  Edge.swift
//  
//
//  Created by Lonnie on 2020/12/25.
//

import Foundation
public class Edge {

    public let v: Int
    
    public let w: Int
    
    public let weight: Double
    
    public required init(_ v: Int, _ w: Int, _ weight: Double) {
        self.v = v
        self.w = w
        self.weight = weight
    }
    
    public func either() -> Int {
        v
    }
    
    public func other(_ vertex: Int) throws -> Int {
        if vertex == v { return w }
        if vertex == w { return v }
        throw FoundationError.invalidCoding
    }
    
}

extension Edge: Comparable {
    
    public static func < (lhs: Edge, rhs: Edge) -> Bool {
        lhs.weight < rhs.weight
    }
    
    public static func == (lhs: Edge, rhs: Edge) -> Bool {
        lhs.v == rhs.v && lhs.w == rhs.w && lhs.weight == rhs.weight
    }
    
}

extension Edge: StringConvertable {
    public func toString() -> String {
        "\(v)-\(w) \(weight)"
    }
    
    public static func fromString(_ string: String) throws -> Self {
        let components = string.components(separatedBy: " ")
        if components.count != 2 { throw FoundationError.invalidCoding }
        let edgePart = components[0]
        let weightPart = components[1]
        let edges = edgePart.components(separatedBy: "-")
        guard
            let v = Int(edges[0]),
            let w = Int(edges[1]),
            let weight = Double(weightPart) else {
            throw FoundationError.invalidCoding
        }
        return Self(v, w, weight)
    }
}
