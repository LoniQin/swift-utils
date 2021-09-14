
//
//  DirectedGraphTestCase.swift
//
//
//  Created by lonnie on 2020/11/14.
//

import Foundation
import XCTest
@testable import SwiftUtils

final class DirectedGraphTestCase: XCTestCase {
    
    func testDirectedGraph() {
        let graph = DirectedGraph(10)
        graph.addEdge(1, 2)
        Array(graph.adj(1)).assert.equal([2])
        Array(graph.adj(2)).assert.equal([])
        graph.indegree(1).assert.equal(0)
        graph.indegree(2).assert.equal(1)
        graph.outdegree(1).assert.equal(1)
        graph.outdegree(2).assert.equal(0)
        graph.addEdge(1, 3)
        Array(graph.adj(1)).assert.equal([3, 2])
        Array(graph.adj(3)).assert.equal([])
        graph.indegree(1).assert.equal(0)
        graph.outdegree(1).assert.equal(2)
    }
    
    func testLeetcode997() {
        class Solution {
            func findJudge(_ N: Int, _ trust: [[Int]]) -> Int {
                let graph = DirectedGraph(N)
                for item in trust {
                    graph.addEdge(item[0] - 1, item[1] - 1)
                }
                // Find Judeg
                var judgeIndex = -1
                for i in 0..<N {
                    if graph.outdegree(i) == 0 {
                        if judgeIndex == -1 {
                            judgeIndex = i
                        } else {
                            return -1
                        }
                    }
                }
                for i in 0..<N {
                    if i != judgeIndex {
                        var exists = false
                        for j in graph.adj(i) {
                            if j == judgeIndex {
                                exists = true
                                break
                            }
                        }
                        if !exists {
                            return -1
                        }
                    }
                }
                return  judgeIndex == -1 ? -1: judgeIndex + 1
            }
        }
        let solution = Solution()
        solution.findJudge(2, [[1,2]]).assert.equal(2)
        solution.findJudge(3, [[1,3],[2,3]]).assert.equal(3)
        solution.findJudge(3, [[1,3],[2,3],[3,1]]).assert.equal(-1)
        solution.findJudge(4, [[1,3],[1,4],[2,3],[2,4],[4,3]]).assert.equal(3)
    }
    
}
