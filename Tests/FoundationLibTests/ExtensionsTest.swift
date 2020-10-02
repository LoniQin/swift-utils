//
//  ExtensionsTest.swift
//
//
//  Created by lonnie on 2020/9/26.
//

import XCTest
@testable import FoundationLib
fileprivate class A: NSObject {
    var intValue: Int = 0
    var doubleValue: Double = 0.0
    var stringValue: String = ""
}
import CommonCrypto
final class ExtensionsTest: XCTestCase {
    
    func testNSOBjectExtension() {
        
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
        UIView.className().assert.equal("UIView")
    }
    
    func testInt() {
        let a = 1
        a.int.assert.equal(1)
        a.float.assert.equal(1)
        a.double.assert.equal(1)
        a.uint.assert.equal(1)
    }
    
    func testString() {
        let a = "29833"
        a.int.assert.equal(29833)
        a.float.assert.equal(29833)
        a.double.assert.equal(29833)
        a.uint.assert.equal(29833)
        ("a" / "b").assert.equal("a/b")
        ("a" - "b").assert.equal("a-b")
    }
    
    static var allTests = [
        ("testNSOBjectExtension", testNSOBjectExtension)
    ]
}
