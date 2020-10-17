
//
//  GraphProtocolTestCase.swift
//
//
//  Created by lonnie on 2020/10/17.
//

import Foundation
import XCTest
@testable import FoundationLib

final class GraphProtocolTestCase: XCTestCase {
    
    func testGraph() throws {
        let graph = try Graph(URL(fileURLWithPath: dataPath() / "mediumG.txt"))
        graph.maxDegree().assert.equal(21)
        graph.averageDegree().assert.equal(10)
        graph.numberOfSelfLoops().assert.equal(0)
        let newGraph = try Graph.fromString(graph.toString())
        graph.maxDegree().assert.equal(newGraph.maxDegree())
        graph.averageDegree().assert.equal(newGraph.averageDegree())
        graph.numberOfSelfLoops().assert.equal(newGraph.numberOfSelfLoops())
    }
}
