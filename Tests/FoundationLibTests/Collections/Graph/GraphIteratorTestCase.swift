
//
//  GraphIteratorTestCase.swift
//
//
//  Created by lonnie on 2020/11/14.
//

import Foundation
import XCTest
@testable import FoundationLib

final class GraphIteratorTestCase: XCTestCase {
    func testGraphIterator() throws {
        /*
             0
            /  \
           1      2
          / \    /  \
         3 <- 4  5 <- 6
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
        var bfsItems = [Int]()
        var dfsItems = [Int]()
        let bfs = GraphIterator(graph, .bfs, [0]) {
            bfsItems.append($0.to)
        }
        bfs.begin()
        let dfs = GraphIterator(graph, .dfs, [0]) {
            dfsItems.append($0.to)
        }
        dfs.begin()
        dfsItems.assert.equal([0, 2, 6, 5, 1, 4, 3])
        print("BFS: ", bfsItems)
        print("DFS: ", dfsItems)
    }
}
