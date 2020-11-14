//
//  GraphPathFinder.swift
//  
//
//  Created by lonnie on 2020/11/14.
//

import Foundation

public class GraphPathFinder<T: GraphProtocol> {
    
    let iterator: GraphIterator<T>
    
    var edgeTo: [Int]
    
    var distanceTo: [Int]
    
    var start: Int
    
    public init(
        _ graph: T ,
        _ method: GraphIterator<T>.Method,
        _ start: Int
    ) {
        self.iterator = GraphIterator(graph, method, [start])
        self.start = start
        self.edgeTo = [Int](repeating: Int.max, count: iterator.graph.vertexCount)
        self.distanceTo = [Int](repeating: Int.max, count: iterator.graph.vertexCount)
    }
    
    public func begin() {
        self.iterator.block = { [unowned self] edge in
            self.edgeTo[edge.to] = edge.from
            if edge.from == -1 {
                self.distanceTo[edge.to] = 0
            } else {
                self.distanceTo[edge.to] = self.distanceTo[edge.from] + 1
            }
        }
        self.iterator.begin()
    }
    
    func hasPath(to: Int) -> Bool {
        iterator.visited(to)
    }
    
    func distance(to v: Int) -> Int {
        return distanceTo[v]
    }
    
    func path(to v: Int) -> Stack<Int> {
        let stack = Stack<Int>()
        if !hasPath(to: v) { return stack }
        var x = v
        while x != start {
            stack.push(x)
            x = edgeTo[x]
        }
        stack.push(start)
        return stack
    }
    
}
