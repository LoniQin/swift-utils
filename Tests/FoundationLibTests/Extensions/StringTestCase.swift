
//
//  StringTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import FoundationLib

final class StringTestCase: XCTestCase {
    
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
    
    func testStringExtensions() {
        let str = "hello world"
        str.appendingSuffix(";").assert.equal("hello world;")
        str.appendingPrefix("Lonnie:").assert.equal("Lonnie:hello world")
        str.appendingSuffix(";").assert.equal("hello world;")
        str.appendingSuffix("world").assert.equal("hello world")
        str.appendingPrefix("hello").assert.equal("hello world")
        ("user" / "login").assert.equal("user/login")
        ("111" * 3).assert.equal("111111111")
        ("111" - "222").assert.equal("111-222")
    }
}
