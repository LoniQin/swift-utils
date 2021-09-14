
//
//  NodeTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import SwiftUtils

final class NodeTestCase: XCTestCase {
     
    func testNode() {
        //
        var node: ListNode<Int>?
        for i in 0..<100 {
            if node == nil {
                node = ListNode(i)
            } else {
                node = ListNode(i, node)
            }
        }
        Array(node!).assert.equal(Array(0..<100).reversed())
        XCTAssertNotNil(node)
        
    }
    
}
