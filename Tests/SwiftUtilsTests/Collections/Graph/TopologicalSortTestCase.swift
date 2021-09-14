
//
//  TopologicalSortTestCase.swift
//
//
//  Created by lonnie on 2020/11/14.
//

import Foundation
import XCTest
@testable import SwiftUtils

final class TopologicalSortTestCase: XCTestCase {
    func testTopologicalSort() {
        self.expectation { exp in
             HttpClient.default.download("https://algs4.cs.princeton.edu/42digraph/jobs.txt") { (result: Result<String, Error>) in
                 do {
                    let items = try result.get().components(separatedBy: .newlines).map { $0.components(separatedBy: "/").filter { !$0.isEmpty }
                    }.filter{ !$0.isEmpty }
                    var stringIndex: [String: Int] = [:]
                    var count = 0
                    for item in items {
                        for element in item {
                            if stringIndex[element] == nil {
                                stringIndex[element] = count
                                count += 1
                            }
                        }
                    }
                    print(count, stringIndex)
                    var indexString: [Int: String] = [:]
                    for (key, value) in stringIndex {
                        indexString[value] = key
                    }
                    let digraph = DirectedGraph(count)
                    for item in items {
                        for i in 1..<item.count {
                            digraph.addEdge(
                                stringIndex[item[0]]!,
                                stringIndex[item[i]]!
                            )
                        }
                    }
                    let sort = TopologicalSort(digraph)
                    var courses = [String]()
                    if let order = sort.order {
                        for item in order {
                            courses.append(indexString[item]!)
                        }
                    }
                    courses.assert.equal(Array {
                        "Calculus"
                        "Linear Algebra"
                        "Introduction to CS"
                        "Advanced Programming"
                        "Algorithms"
                        "Theoretical CS"
                        "Artificial Intelligence"
                        "Robotics"
                        "Machine Learning"
                        "Neural Networks"
                        "Databases"
                        "Scientific Computing"
                        "Computational Biology"
                    })
                    exp.fulfill()
                 } catch let error {
                     print(error)
                 }
             }
        }
    }
}
