
//
//  DepthFirstSearchTestCase.swift
//
//
//  Created by lonnie on 2020/11/14.
//

import Foundation
import XCTest
@testable import FoundationLib

final class DepthFirstSearchTestCase: XCTestCase {
    
    func testDiGraph() throws {
        let graph = try DirectedGraph(URL(fileURLWithPath: dataPath() / "directed_graph"), sepearator: .init(charactersIn: "→"))
        graph.vertexCount.assert.equal(13)
        graph.edgeCount.assert.equal(22)
        
        let dfs = DepthFirstSearch(graph, 4)
        let document = bootstrap_document {
            h1("Directed Graph")
            table {
                thead {
                    tr {
                        th("v")(scope: "col")
                        th("marked[]")(scope: "col")
                    }
                }
                tbody {
                    For(0..<graph.vertexCount) { index in
                        tr {
                            td("\(index)")
                            td("\(dfs.visited(index))")
                        }(scope: "row")
                    }
                }
            }(class: "table table-dark")
        }
        let path = dataPath() / "directed_graph.html"
        try FileManager.default.removeFileIfExist(path)
        try document.write(to: path)
    }
    
}
