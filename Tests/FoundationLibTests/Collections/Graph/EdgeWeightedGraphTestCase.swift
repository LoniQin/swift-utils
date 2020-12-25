//
//  EdgeWeightedGraphTestCase.swift
//  
//
//  Created by Lonnie on 2020/12/25.
//

import Foundation
import XCTest
@testable import FoundationLib

class EdgeWeightedGraphTestCase: XCTestCase {
    
    func testEdgeWeightedGraph() {
        self.expectation { (exp) in
            HttpClient.default.download("https://algs4.cs.princeton.edu/43mst/tinyEWG.txt") { (result: Result<EdgeWeightedGraph, Error>) in
                do {
                    let graph = try result.get()
                    graph.vertexCount.assert.equal(8)
                    graph.edgeCount.assert.equal(16)
                    graph.adj[0].count.assert.equal(4)
                    graph.adj[1].count.assert.equal(4)
                    graph.adj[2].count.assert.equal(5)
                    graph.adj[3].count.assert.equal(3)
                    graph.adj[4].count.assert.equal(4)
                    self.testLazyPrim(graph, 1.81)
                    try self.testPrim(graph, 1.81)
                    exp.fulfill()
                } catch let error {
                    print(error)
                }
            }
        }
        
    }
    
    func testEdgeWeightedGraph2() {
        self.expectation { (exp) in
            HttpClient.default.download("https://algs4.cs.princeton.edu/43mst/mediumEWG.txt") { (result: Result<EdgeWeightedGraph, Error>) in
                do {
                    let graph = try result.get()
                    self.testLazyPrim(graph, 10.46351)
                    try self.testPrim(graph, 10.46351)
                    exp.fulfill()
                } catch let error {
                    print(error)
                }
            }
        }
        
    }
    
    func testLazyPrim(_ graph: EdgeWeightedGraph, _ value: Double) {
        let prim = LazyPrimMST(graph)
        prim.start()
        abs(prim.weight - value).assert.lessThan(1e-3)
    }
    
    func testPrim(_ graph: EdgeWeightedGraph, _ value: Double) throws {
        let prim = PrimMST(graph)
        try prim.start()
        abs(prim.weight() - value).assert.lessThan(1e-3)
    }
}
