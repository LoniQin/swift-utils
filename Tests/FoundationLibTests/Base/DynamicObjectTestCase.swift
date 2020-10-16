
//
//  DynamicObjectTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import FoundationLib

final class DynamicObjectTestCase: XCTestCase {
    
    func testMathObject() throws {
        
        class Math: DynamicObject {
            
            subscript(dynamicMember member: String) -> (Double) -> (Double) {
                get {
                    params[member] as! ((Double)->(Double))
                }
                set {
                    params[member] = newValue
                }
            }
            
            subscript(dynamicMember member: String) -> (Double, Double) -> (Double) {
                get {
                    params[member] as! ((Double, Double)->(Double))
                }
                set {
                    params[member] = newValue
                }
            }
            
        }
        let math = Math()
        math.add = {
            $0 + $1
        }
        math.minus = {
            $0 - $1
        }
        math.multiply = {
            $0 * $1
        }
        math.divide = {
            $0 / $1
        }
        math.negate = {
            -$0
        }
        math.sin = {
            sin($0)
        }
        math.cos = {
            cos($0)
        }
        math.tan = {
            tan($0)
        }
        math.add(2, 3).assert.equal(5)
        math.minus(11, 4).assert.equal(7)
        math.multiply(33, 3).assert.equal(99)
        math.divide(44, 4).assert.equal(11)
        math.negate(5).assert.equal(-5)
        let sequence = (0..<1.million).map(Double.init)
        try DebugLogger.default.measure(description: "Caulcate sin(x) with dynamic object") {
            autoreleasepool {
                sequence.forEach {
                    _ = math.sin($0)
                }
            }
        }
        try DebugLogger.default.measure(description: "Caulcate sin(x) with original function") {
            autoreleasepool {
                sequence.forEach {
                    _ = sin($0)
                }
            }
        }
    }
    
    func testDynamicObject() throws {
        let dog = DynamicObject.new(name: "Lily", age: 12)
        dog.name.assert.equal("Lily")
        dog.age.assert.equal(12)
        dog.increaseAge = {
            dog.age += 1
        }
        dog.increaseAge()
        dog.age.assert.equal(13)
        let sequence = (0..<1.million).map({$0})
        try DebugLogger.default.measure(description: "Write to DynamicObject") {
            for i in sequence {
                dog.dynamicallyCall(withKeywordArguments: KeyValuePairs(dictionaryLiteral: (i.description, i)))
            }
        }
        try DebugLogger.default.measure(description: "Access integer using DynamicObject") {
            var value: Int = 0
            for _ in 0..<1.million {
                value = dog.100000
            }
            value.assert.equal(100000)
        }
        try DebugLogger.default.measure(description: "Access integer using Dictionary") {
            var value: Int = 0
            for i in 0..<1.million {
                value = dog.params[String(i)] as! Int
            }
            value.assert.equal(1.million-1)
        }
        try DebugLogger.default.measure(description: "Access integer using Array") {
            for i in 0..<1.million {
                _ = sequence[i]
            }
        }
    }
    
}
