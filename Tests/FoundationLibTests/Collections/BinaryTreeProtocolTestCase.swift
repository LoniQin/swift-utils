
//
//  BinaryTreeProtocolTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import FoundationLib

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
    
}
