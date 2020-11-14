
//
//  GraphPathFinderTestCase.swift
//
//
//  Created by lonnie on 2020/11/14.
//

import Foundation
import XCTest
@testable import FoundationLib

final class GraphPathFinderTestCase: XCTestCase {
    func testSample() {
        
        /*
             0
            /  \
           1    2
          / \  /  \
         3 <- 4 5 <- 6
        */
        let graph = DirectedGraph(7)
        graph.addEdge(0, 1)
        graph.addEdge(0, 2)
        graph.addEdge(1, 3)
        graph.addEdge(1, 4)
        graph.addEdge(2, 5)
        graph.addEdge(2, 6)
        graph.addEdge(4, 3)
        graph.addEdge(6, 5)
        var finder = GraphPathFinder(graph, .bfs, 0)
        finder.begin()
        Array(finder.path(to: 4)).assert.equal([0, 1, 4])
        Array(finder.path(to: 3)).assert.equal([0, 1, 3])
        Array(finder.path(to: 5)).assert.equal([0, 2, 5])
        
        finder = GraphPathFinder(graph, .bfs, 5)
        finder.begin()
        Array(finder.path(to: 0)).assert.equal([])
    }
}
