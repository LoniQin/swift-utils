
//
//  GraphCycleFinderTestCase.swift
//
//
//  Created by lonnie on 2020/11/14.
//

import Foundation
import XCTest
@testable import SwiftUtils

final class GraphCycleFinderTestCase: XCTestCase {
    func testSample() {
        self.expectation { exp in
             HttpClient.default.download("https://algs4.cs.princeton.edu/42digraph/tinyDAG.txt") { (result: Result<DirectedGraph, Error>) in
                 do {
                    let graph = try result.get()
                    let dfs = GraphDepthFirstOrder(graph)
                    Array(dfs.preOrder).assert.equal([0, 5, 4, 1, 6, 9, 11, 12, 10, 2, 3, 7, 8])
                    Array(dfs.postOrder).assert.equal([4, 5, 1, 12, 11, 10, 9, 6, 0, 3, 2, 7, 8])
                    Array(dfs.reversePostOrder).assert.equal([8, 7, 2, 3, 0, 6, 9, 10, 11, 12, 1, 5, 4 ])
                    exp.fulfill()
                 } catch let error {
                     print(error)
                 }
             }
         }
    }
}
