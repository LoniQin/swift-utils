
//
//  BagTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import SwiftUtils

final class BagTestCase: XCTestCase {
    
    func testBag() throws {
        let bag = Bag<Int>()
        try DebugLogger.default.measure(description: "Append item in bag") {
            for i in 0..<1.million {
                bag.add(i)
            }
        }
        try DebugLogger.default.measure(description: "Iterate item in bag") {
            for _ in bag {
                
            }
        }
        try DebugLogger.default.measure(description: "Compare equal") {
            Array(bag).assert.equal((0..<1.million).reversed())
        }
        
    }
    
}
