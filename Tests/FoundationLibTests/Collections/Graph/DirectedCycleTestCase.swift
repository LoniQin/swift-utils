
//
//  DirectedCycleTestCase.swift
//
//
//  Created by lonnie on 2020/11/14.
//

import Foundation
import XCTest
@testable import FoundationLib

final class DirectedCycleTestCase: XCTestCase {
    func testGraphCycleFinder() throws {
       self.expectation { exp in
            HttpClient.default.download("https://algs4.cs.princeton.edu/42digraph/tinyDG.txt") { (result: Result<DirectedGraph, Error>) in
                do {
                    let graph = try result.get()
                    let finder = GraphCycleFinder(graph)
                    XCTAssertNotNil(finder.cycle)
                    if let cycle = finder.cycle {
                        Array(cycle).assert.equal([3, 5, 4, 3])
                    }
                    exp.fulfill()
                    print(graph)
                } catch let error {
                    print(error)
                }
            }
        }
        self.expectation { exp in
             HttpClient.default.download("https://algs4.cs.princeton.edu/42digraph/tinyDAG.txt") { (result: Result<DirectedGraph, Error>) in
                 do {
                     let graph = try result.get()
                     let finder = GraphCycleFinder(graph)
                     XCTAssertNil(finder.cycle)
                     exp.fulfill()
                     print(graph)
                 } catch let error {
                     print(error)
                 }
             }
        }
    }
}
