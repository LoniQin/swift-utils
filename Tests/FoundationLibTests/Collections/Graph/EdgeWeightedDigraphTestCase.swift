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
            HttpClient.default.download("https://algs4.cs.princeton.edu/43mst/tinyEWG.txt") { (result: Result<EdgeWeightedDigraph, Error>) in
                do {
                    let graph = try result.get()
                    graph.vertexCount.assert.equal(8)
                    exp.fulfill()
                } catch let error {
                    print(error)
                }
            }
        }
        
    }
  
}
