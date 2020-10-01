//
//  ExtensionsTest.swift
//
//
//  Created by lonnie on 2020/9/26.
//

import XCTest
@testable import FoundationLib
import CommonCrypto
final class ExtensionsTest: XCTestCase {
    
    func testNSOBjectExtension() {
        class A: NSObject {
            var intValue: Int = 0
            var doubleValue: Double = 0.0
            var stringValue: String = ""
        }
        let a = A()
        a.then {
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
    }
    
    static var allTests = [
        ("testNSOBjectExtension", testNSOBjectExtension)
    ]
}
