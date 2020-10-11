//
//  ExtensionsTest.swift
//
//
//  Created by lonnie on 2020/9/26.
//

import XCTest
@testable import FoundationLib
import CommonCrypto
fileprivate class A: NSObject {
    var intValue: Int = 0
    var doubleValue: Double = 0.0
    var stringValue: String = ""
}
final class ExtensionsTest: XCTestCase {
    
    func testNSOBjectExtension() throws {
        
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
        try DebugLogger.default.measure(desc: "Get and set with associated value") {
            for i in 0..<1.million {
                key = "key\(i)"
                a.setAssociatedValue(i, with: &key)
                value = a.getAssociatedValue(with: &key)//.assert.equal(i)
            }
        }
        var dictionary = [String: Any]()
        
        try DebugLogger.default.measure(desc: "Get and set with dictionary") {
            for i in 0..<1.million {
                key = "key\(i)"
                dictionary[key] = i
                value = dictionary.get(key)
            }
        }
        
        try DebugLogger.default.measure(desc: "Get and set with attribute") {
            for i in 0..<1.million {
                a.intValue = i
                value = a.intValue
            }
        }
        value.assert.equal(1.million - 1)
        
    }
    
    func testInt() {
        let a = 1
        a.int.assert.equal(1)
        a.float.assert.equal(1)
        a.double.assert.equal(1)
        a.uint.assert.equal(1)
        99999.toBinaryString().assert.equal("11000011010011111")
        var value = 3567
        value.increasing().assert.equal(3568)
        value.decreasing().assert.equal(3567)
        
    }
    
    func testFloat() {
        let value: Float = 999
        value.int.assert.equal(999)
        value.float.assert.equal(999)
        value.double.assert.equal(999)
        value.uint.assert.equal(999)
    }
    
    func testDouble() {
        let value: Double = 999
        value.int.assert.equal(999)
        value.float.assert.equal(999)
        value.double.assert.equal(999)
        value.uint.assert.equal(999)
    }
    
    func testUInt() {
        let value: UInt = 999
        value.int.assert.equal(999)
        value.float.assert.equal(999)
        value.double.assert.equal(999)
        value.uint.assert.equal(999)
    }
    
    func testString() {
        let a = "29833"
        a.int.assert.equal(29833)
        a.float.assert.equal(29833)
        a.double.assert.equal(29833)
        a.uint.assert.equal(29833)
        ("a" / "b").assert.equal("a/b")
        ("a" - "b").assert.equal("a-b")
        "%@-%@".interpolation("a", "b").assert.equal("a-b")
        "%d-%d".interpolation(2, 3).assert.equal("2-3")
        ("999999" * 3).assert.equal("999999999999999999")
        (3 * "999999").assert.equal("999999999999999999")
    }
    
    func testDispatchQueue() throws {
        let exp = self.expectation(description: #function)
        var value = 1
        value = try DispatchQueue.sync(onMain: {
            value + 1
        })
        DispatchQueue.main.after(1.0) {
            value += 5
            exp.fulfill()
        }
        waitForExpectations(timeout: 1.1) { (error) in
            value.assert.equal(7)
        }
    }
    
    func testNumericExtension() {
        9.hundred.assert.equal(900)
        9.thouthand.assert.equal(9000)
        9.million.assert.equal(9000000)
        9.billion.assert.equal(9000000000)
    }
    
    static var allTests = [
        ("testNSOBjectExtension", testNSOBjectExtension)
    ]
}
