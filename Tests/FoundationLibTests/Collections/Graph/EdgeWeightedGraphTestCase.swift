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
                } catch let error {
                    print(error)
                }
                exp.fulfill()
            }
        }
        
    }
}
