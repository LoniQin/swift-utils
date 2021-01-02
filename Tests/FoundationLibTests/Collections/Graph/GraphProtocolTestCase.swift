
//
//  GraphProtocolTestCase.swift
//
//
//  Created by lonnie on 2020/11/14.
//

import Foundation
import XCTest
@testable import FoundationLib

final class GraphProtocolTestCase: XCTestCase {
    
    func testGraph() throws {
        self.expectation { exp in
             HttpClient.default.download("https://algs4.cs.princeton.edu/41graph/mediumG.txt") { (result: Result<Graph, Error>) in
                 do {
                    
                    let graph = try result.get()
                    graph.maxDegree().assert.equal(21)
                    graph.averageDegree().assert.equal(10)
                    graph.numberOfSelfLoops().assert.equal(0)
                    let newGraph = try Graph.fromString(graph.toString())
                    graph.maxDegree().assert.equal(newGraph.maxDegree())
                    graph.averageDegree().assert.equal(newGraph.averageDegree())
                    graph.numberOfSelfLoops().assert.equal(newGraph.numberOfSelfLoops())
                    let finder = GraphCycleFinder(graph)
                    XCTAssertNotNil(finder.cycle)
                    if let cycle = finder.cycle {
                        Array(cycle).assert.equal([225, 0, 225])
                    }
                    exp.fulfill()
                    print(graph)
                 } catch let error {
                    print(error)
                 }
             }
         }
    }
}
