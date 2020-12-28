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
    
    private static let epsilon = 1e-3
    
    func testEdgeWeightedDigraph() {
        self.expectation { (exp) in
            HttpClient.default.download("https://algs4.cs.princeton.edu/44sp/tinyEWD.txt") { (result: Result<EdgeWeightedDigraph, Error>) in
                do {
                    let graph = try result.get()
                    graph.vertexCount.assert.equal(8)
                    self.testDijkstraShortestPath(graph)
                } catch let error {
                    print(error)
                }
                exp.fulfill()
            }
        }
        
    }
    
    func testAcyclicEdgeWeightedDigraph() {
        self.expectation { (exp) in
            HttpClient.default.download("https://algs4.cs.princeton.edu/44sp/tinyEWDAG.txt") { (result: Result<EdgeWeightedDigraph, Error>) in
                do {
                    let graph = try result.get()
                    graph.vertexCount.assert.equal(8)
                    try self.testAcyclicShortestPath(graph)
                    try self.testAcyclicLongestPath(graph)
                } catch let error {
                    print(error)
                }
                exp.fulfill()
            }
        }
        
    }
    
    func testDijkstraShortestPath(_ graph: EdgeWeightedDigraph) {
        let dijkstra = DijkstraShortestPath(graph, 0)
        dijkstra.start()
        dijkstra.distTo(0).assert.equal(0)
        let samples = Array {
            0.00
            1.05
            0.26
            0.99
            0.38
            0.73
            1.51
            0.60
        }
        for i in 0..<samples.count {
            dijkstra.distTo(i).assert.approximatelyEqualTo(samples[i])
        }
    }
    
    func testAcyclicShortestPath(_ graph: EdgeWeightedDigraph) throws {
        let sp = try AcyclicShortestPath(graph, 5)
        try sp.start()
        let samples = Array {
            0.73
            0.32
            0.62
            0.61
            0.35
            0.00
            1.13
            0.28
        }
        for i in 0..<samples.count {
            try sp.distTo(i).assert.approximatelyEqualTo(samples[i])
        }
    }
    
    func testAcyclicLongestPath(_ graph: EdgeWeightedDigraph) throws {
        let lp = try AcyclicLongestPath(graph, 5)
        try lp.start()
        let samples = Array {
            2.44
            0.32
            2.77
            0.61
            2.06
            0.00
            1.13
            2.43
        }
        for i in 0..<samples.count {
            try lp.distTo(i).assert.approximatelyEqualTo(samples[i])
        }
    }
    
    func testBellmanFordAlgorithm() {
        self.expectation { (exp) in
            HttpClient.default.download("https://algs4.cs.princeton.edu/44sp/tinyEWDn.txt") { (result: Result<EdgeWeightedDigraph, Error>) in
                do {
                    let graph = try result.get()
                    let sp = try BellmanFordShortestPath(graph, 0)
                    let samples: [Double] = [0, 0.93, 0.26, 0.99, 0.26, 0.61, 1.51, 0.60]
                    for item in samples.enumerated() {
                        sp.distTo(item.offset).assert.approximatelyEqualTo(item.element)
                    }
                } catch let error {
                    print(error)
                }
                exp.fulfill()
            }
        }
    }
    
    func testCPM() {
        self.expectation { expectation in
            HttpClient.default.download("https://algs4.cs.princeton.edu/44sp/jobsPC.txt") { (result: Result<String, Error>) in
                do {
                    var components = try result.get().components(separatedBy: .newlines).filter { !$0.isEmpty }
                    let n = components.removeFirst().int
                    let source = 2 * n
                    let sink = 2 * n + 1
                    let graph = EdgeWeightedDigraph(2 * n + 2)
                    for i in 0..<n {
                        var items = components[i].components(separatedBy: .whitespaces).filter { !$0.isEmpty
                        }
                        let duration = items.removeFirst().double
                        graph.add(.init(source, i, 0.0))
                        graph.add(.init(i + n, sink, 0.0))
                        graph.add(.init(i, i + n, duration))
                        let m = items.removeFirst().int
                        for _ in 0..<m {
                            let precedent = items.removeFirst().int
                            graph.add(.init(n + i, precedent, 0.0))
                        }
                        
                    }
                    let lp = try AcyclicLongestPath(graph, source)
                    try lp.start()
                    print("Job  start   finish")
                    print("-------------------")
                    for i in 0..<n {
                        try print("\(i)\t\(lp.distTo(i))\t\(lp.distTo(i + n))")
                    }
                    try print("Finish time: \(lp.distTo(sink))")
                    print("-------------------")
                    try lp.distTo(sink).assert.approximatelyEqualTo(173.0)
                } catch let error {
                    XCTFail("\(error)")
                }
                expectation.fulfill()
            }
        }
    }
    
    func testArbitrage() {
        self.expectation { expectation in
            HttpClient.default.download("https://algs4.cs.princeton.edu/44sp/rates.txt") { (result: Result<String, Error>) in
                do {
                    var res = try result.get().components(separatedBy: .newlines).filter { !$0.isEmpty }
                    let graph = EdgeWeightedDigraph(res.removeFirst().int)
                    var names: [String] = []
                    for item in res.enumerated() {
                        var components = item.element.components(separatedBy: .whitespaces).filter { !$0.isEmpty }
                        names.append(components.removeFirst())
                        for i in 0..<components.count {
                            let rate = components[i].double
                            let e = DirectedEdge(item.offset, i, -log(rate))
                            graph.add(e)
                        }
                    }
                    let spt = try BellmanFordShortestPath(graph, 0)
                    if let cycle = spt.negativeCycle {
                        var stake: Double = 1000.0
                        for e in cycle {
                            var text = "\(stake) \(names[e.from])"
                            stake *= exp(-e.weight)
                            text.append("=\(stake) \(names[e.to])")
                            print(text)
                        }
                    }
                } catch let error {
                    XCTFail("\(error)")
                }
                expectation.fulfill()
            }
        }
    }
  
}
