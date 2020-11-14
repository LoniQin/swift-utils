
//
//  BreathFirstSearchTestCase.swift
//
//
//  Created by lonnie on 2020/11/14.
//

import Foundation
import XCTest
@testable import FoundationLib

final class BreathFirstSearchTestCase: XCTestCase {
    
    func testBreathFirstSearch() throws {
        let graph = try DirectedGraph(URL(fileURLWithPath: dataPath() / "directed_graph_2"))
        graph.vertexCount.assert.equal(6)
        graph.edgeCount.assert.equal(8)
        let bfs = try BreathFirstSearch(graph, [4]) {
            print("\($0)")
        }
        print(bfs)
    }
    
}
