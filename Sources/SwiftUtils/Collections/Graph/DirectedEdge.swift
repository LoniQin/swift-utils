//
//  DirectedEdge.swift
//  
//
//  Created by Lonnie on 2020/12/25.
//

import Foundation
public class DirectedEdge {
    
    public let from: Int
    
    public let to: Int
    
    public let weight: Double
    
    public init(_ from: Int, _ to: Int, _ weight: Double) {
        self.from = from
        self.to = to
        self.weight = weight
    }
    
}
