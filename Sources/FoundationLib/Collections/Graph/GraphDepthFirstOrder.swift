//
//  GraphDepthFirstOrder.swift
//  
//
//  Created by lonnie on 2020/11/14.
//

import Foundation
public class GraphDepthFirstOrder<G: GraphProtocol> {
    
    var marked: [Bool]
    
    public fileprivate(set) var pre: [Int]
    
    public fileprivate(set) var post: [Int]
    
    public fileprivate(set) var preOrder: Queue<Int>
    
    public fileprivate(set) var postOrder: Queue<Int>
    
    var preCounter = 0
    
    var postCounter = 0
    
    public init(_ g: G) {
        pre = [Int](repeating: 0, count: g.vertexCount)
        post = [Int](repeating: 0, count: g.vertexCount)
        preOrder = Queue<Int>()
        postOrder = Queue<Int>()
        marked = [Bool](repeating: false, count: g.vertexCount)
        for v in 0..<g.vertexCount {
            if !marked[v] {
                dfs(g, v)
            }
        }
    }
    
    func dfs(_ g: G, _ v: Int) {
        marked[v] = true
        pre[v] = preCounter
        preCounter += 1
        preOrder.enqueue(v)
        for w in g.adj(v) {
            if !marked[w] {
                dfs(g, w)
            }
        }
        postOrder.enqueue(v)
        post[v] = postCounter
        postCounter += 1
    }
    
    var reversePostOrder: Stack<Int> {
        let reversed = Stack<Int>()
        for v in postOrder {
            reversed.push(v)
        }
        return reversed
    }
    
}
