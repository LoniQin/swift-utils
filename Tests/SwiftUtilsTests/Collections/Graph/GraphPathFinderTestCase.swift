
//
//  GraphPathFinderTestCase.swift
//
//
//  Created by lonnie on 2020/11/14.
//

import Foundation
import XCTest
@testable import SwiftUtils

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
    
    func testDataOnline() throws {
       self.expectation { exp in
            HttpClient.default.send("https://algs4.cs.princeton.edu/42digraph/tinyDG.txt") { (result: Result<String, Error>) in
                if let graph = try? DirectedGraph(result.get()) {
                    var finder = GraphPathFinder(graph, .dfs, 3)
                    finder.begin()
                    Array(finder.path(to: 0)).assert.equal([3, 5, 4, 2, 0])
                    Array(finder.path(to: 1)).assert.equal([3, 5, 4, 2, 0, 1])
                    Array(finder.path(to: 2)).assert.equal([3, 5, 4, 2])
                    Array(finder.path(to: 4)).assert.equal([3, 5, 4])
                    Array(finder.path(to: 6)).assert.equal([])
                    Array(finder.path(to: 7)).assert.equal([])
                    Array(finder.path(to: 8)).assert.equal([])
                    Array(finder.path(to: 9)).assert.equal([])
                    finder = GraphPathFinder(graph, .bfs, 3)
                    finder.begin()
                    Array(finder.path(to: 0)).assert.equal([3, 2, 0])
                    finder.distance(to: 0).assert.equal(2)
                    Array(finder.path(to: 1)).assert.equal([3, 2, 0, 1])
                    finder.distance(to: 1).assert.equal(3)
                    Array(finder.path(to: 2)).assert.equal([3, 2])
                    finder.distance(to: 2).assert.equal(1)
                    Array(finder.path(to: 3)).assert.equal([3])
                    finder.distance(to: 3).assert.equal(0)
                    Array(finder.path(to: 4)).assert.equal([3, 5, 4])
                    finder.distance(to: 4).assert.equal(2)
                    Array(finder.path(to: 5)).assert.equal([3, 5])
                    finder.distance(to: 5).assert.equal(1)
                    Array(finder.path(to: 6)).assert.equal([])
                    finder.distance(to: 6).assert.equal(.max)
                    Array(finder.path(to: 7)).assert.equal([])
                    finder.distance(to: 7).assert.equal(.max)
                    Array(finder.path(to: 8)).assert.equal([])
                    finder.distance(to: 8).assert.equal(.max)
                    Array(finder.path(to: 9)).assert.equal([])
                    Array(finder.path(to: 10)).assert.equal([])
                    finder.distance(to: 10).assert.equal(.max)
                    Array(finder.path(to: 11)).assert.equal([])
                    finder.distance(to: 11).assert.equal(.max)
                    Array(finder.path(to: 12)).assert.equal([])
                    finder.distance(to: 12).assert.equal(.max)
                    exp.fulfill()
                }
            }
        }
        
    }
}
