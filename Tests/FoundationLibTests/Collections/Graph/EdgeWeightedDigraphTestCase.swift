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
                    exp.fulfill()
                } catch let error {
                    print(error)
                }
            }
        }
        
    }
  
}
