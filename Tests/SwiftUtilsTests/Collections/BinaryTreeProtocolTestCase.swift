
//
//  BinaryTreeProtocolTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import SwiftUtils

final class BinaryTreeProtocolTestCase: XCTestCase {
    
    func testBinaryTree() {
        let tree = RedBlackTree<Int, Int>()
        let sequence = Array(0..<1.hundred)
        for item in sequence {
            tree[item] = item
        }
        let items = tree.root!.array(.middleorder).map { $0.1 }
        items.assert.equal(sequence)
    }
    
    func testLevelOrder() {
        
        class Queue<T> {
            
            class Node {
                
                public var value: T
                
                public var next: Node?
                
                public init(_ value: T, _ next: Node? = nil) {
                    self.value = value
                    self.next = next
                }

            }
            
            var first: Node?
            
            var last: Node?
            
            var count: Int = 0
            
            var isEmpty: Bool {
                count == 0
            }
            
            public func enqueue(_ item: T) {
                let oldLast = last
                last = Node(item)
                if count == 0 {
                    first = last
                } else {
                    oldLast?.next = last
                }
                count += 1
            }
            
            @discardableResult
            public func dequeue() throws -> T {
                guard let value = first?.value else {
                    throw FoundationError.emptyCollection
                }
                first = first?.next
                if count == 0 { last = nil }
                count -= 1
                return value
            }
        }

        final class TreeNode {
            typealias T = Int
            
            var val: Int

             var left: TreeNode?
             var right: TreeNode?
             init(_ val: Int) {
                
                 self.val = val
                 self.left = nil
                 self.right = nil
            }
        }
        
        class Solution {
            
            func levelOrder(_ root: TreeNode?) -> [[Int]] {
                guard let root = root else { return [] }
                let queue = Queue<(Int, TreeNode)>()
                var items = [[Int]]()
                queue.enqueue((0, root))
                bfs(queue: queue, items: &items)
                return items
            }
            
            func bfs(queue: Queue<(Int, TreeNode)>, items: inout [[Int]]) {
                while !queue.isEmpty {
                    let item = try! queue.dequeue()
                    if item.0 == items.count {
                        items.append([])
                    }
                    items[item.0].append(item.1.val)
                    if let left = item.1.left {
                        queue.enqueue((item.0 + 1, left))
                    }
                    if let right = item.1.right {
                        queue.enqueue((item.0 + 1, right))
                    }
                }
            }

        }
        
        let node = TreeNode(3)
        node.left = TreeNode(9)
        node.right = TreeNode(20)
        node.right?.left = TreeNode(15)
        node.right?.right = TreeNode(7)
        let solution = Solution()
        let result = solution.levelOrder(node)
        result.assert.equal([[3], [9, 20], [15, 7]])
        let tree = BinaryTree(3)
        tree.left = .init(9)
        tree.right = .init(20)
        tree.right?.left = .init(15)
        tree.right?.right = .init(7)
        result.flatMap { $0 }.assert.equal(tree.array(.levelorder))
    }
    
}
