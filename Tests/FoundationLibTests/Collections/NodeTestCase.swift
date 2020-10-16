
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
        var node: Node<Int>?
        for i in 0..<100 {
            if node == nil {
                node = Node(i)
            } else {
                node = Node(i, node)
            }
        }
        XCTAssertNotNil(node)
        
    }
    
}
