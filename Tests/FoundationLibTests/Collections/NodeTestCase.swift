
//
//  NodeTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import FoundationLib

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
        XCTAssertNotNil(node)
        
    }
    
}
