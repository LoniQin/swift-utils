//
//  EdgeWeightedGraphTestCase.swift
//  
//
//  Created by Lonnie on 2020/12/25.
//

import Foundation
import XCTest
@testable import FoundationLib

class EdgeWeightedDigraphTestCase: XCTestCase {
    
    func testEdgeWeightedDigraph() {
        self.expectation { (exp) in
            HttpClient.default.download("https://algs4.cs.princeton.edu/44sp/tinyEWD.txt") { (result: Result<EdgeWeightedDigraph, Error>) in
                do {
                    let graph = try result.get()
                    graph.vertexCount.assert.equal(8)
                    self.testDijkstraShortestPath(graph)
                    
                } catch let error {
                    print(error)
                }
                exp.fulfill()
            }
        }
        
    }
    
    func testAcyclicEdgeWeightedDigraph() {
        self.expectation { (exp) in
            HttpClient.default.download("https://algs4.cs.princeton.edu/44sp/tinyEWDAG.txt") { (result: Result<EdgeWeightedDigraph, Error>) in
                do {
                    let graph = try result.get()
                    graph.vertexCount.assert.equal(8)
                    try self.testAcyclicShortestPath(graph)
                } catch let error {
                    print(error)
                }
                exp.fulfill()
            }
        }
        
    }
    
    func testDijkstraShortestPath(_ graph: EdgeWeightedDigraph) {
        let dijkstra = DijkstraShortestPath(graph, 0)
        dijkstra.start()
        dijkstra.distTo(0).assert.equal(0)
        abs(dijkstra.distTo(1) - 1.05).assert.lessThan(1e-3)
        abs(dijkstra.distTo(2) - 0.26).assert.lessThan(1e-3)
        abs(dijkstra.distTo(3) - 0.99).assert.lessThan(1e-3)
        abs(dijkstra.distTo(4) - 0.38).assert.lessThan(1e-3)
        abs(dijkstra.distTo(5) - 0.73).assert.lessThan(1e-3)
        abs(dijkstra.distTo(6) - 1.51).assert.lessThan(1e-3)
        abs(dijkstra.distTo(7) - 0.60).assert.lessThan(1e-3)
    }
    
    func testAcyclicShortestPath(_ graph: EdgeWeightedDigraph) throws {
        let sp = try AcyclicShortestPath(graph, 5)
        try sp.start()
        try abs(sp.distTo(0) - 0.73).assert.lessThan(1e-3)
        try abs(sp.distTo(1) - 0.32).assert.lessThan(1e-3)
        try abs(sp.distTo(2) - 0.62).assert.lessThan(1e-3)
        try abs(sp.distTo(3) - 0.61).assert.lessThan(1e-3)
        try abs(sp.distTo(4) - 0.35).assert.lessThan(1e-3)
        try abs(sp.distTo(5) - 0.00).assert.lessThan(1e-3)
        try abs(sp.distTo(6) - 1.13).assert.lessThan(1e-3)
        try abs(sp.distTo(7) - 0.28).assert.lessThan(1e-3)
    }
  
}
