
//
//  ConfigurableTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import FoundationLib

final class ConfigurableTestCase: XCTestCase {
    func testConfigurable() {
        class A: Configurable {
            var a = 1
            var b = ""
            var c = 3
        }
        let a = A()
        a.with(\.a, 2).with(\.b, "b").with(\.c, 4)
        a.a.assert.equal(2)
        a.b.assert.equal("b")
        a.c.assert.equal(4)
    }
}
