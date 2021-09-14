
//
//  GraphTestCase.swift
//
//
//  Created by lonnie on 2020/11/14.
//

import Foundation
import XCTest
@testable import SwiftUtils

final class GraphTestCase: XCTestCase {
    
    func testGraph() {
        let graph = Graph(10)
        graph.addEdge(1, 2)
        Array(graph.adj(1)).assert.equal([2])
        Array(graph.adj(2)).assert.equal([1])
        graph.degree(1).assert.equal(1)
        graph.degree(2).assert.equal(1)
        graph.addEdge(1, 3)
        Array(graph.adj(1)).assert.equal([3, 2])
        graph.degree(1).assert.equal(2)
    }
    
}
