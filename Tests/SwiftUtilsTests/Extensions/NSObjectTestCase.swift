
//
//  NSObjectTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import SwiftUtils

final class NSObjectTestCase: XCTestCase {
    
    func testNSOBject() throws {
        
        class A: NSObject {
            var intValue: Int = 0
            var doubleValue: Double = 0.0
            var stringValue: String = ""
        }
        
        let a = A().then {
            $0.doubleValue = 2
            $0.intValue = 3
            $0.stringValue = "a"
        }
        a.intValue.assert.equal(3)
        a.doubleValue.assert.equal(2)
        a.stringValue.assert.equal("a")
        a.with {
            $0.doubleValue = 4
            $0.intValue = 5
            $0.stringValue = "b"
        }
        a.intValue.assert.equal(5)
        a.doubleValue.assert.equal(4)
        a.stringValue.assert.equal("b")
        a.do {
            $0.doubleValue = 6
            $0.intValue = 7
            $0.stringValue = "c"
        }
        a.intValue.assert.equal(7)
        a.doubleValue.assert.equal(6)
        a.stringValue.assert.equal("c")
        var key = "key"
        a.setAssociatedValue(255, with: &key)
        a.getAssociatedValue(with: &key).assert.notNil().equal(255)
        var value: Int? = nil
        try DebugLogger.default.measure(description: "Get and set with associated value") {
            for i in 0..<1.million {
                key = "key\(i)"
                a.setAssociatedValue(i, with: &key)
                value = a.getAssociatedValue(with: &key)//.assert.equal(i)
            }
        }
        var dictionary = [String: Any]()
        
        try DebugLogger.default.measure(description: "Get and set with dictionary") {
            for i in 0..<1.million {
                key = "key\(i)"
                dictionary[key] = i
                value = dictionary.get(key)
            }
        }
        
        try DebugLogger.default.measure(description: "Get and set with attribute") {
            for i in 0..<1.million {
                a.intValue = i
                value = a.intValue
            }
        }
        value.assert.equal(1.million - 1)
        
    }
    
}
