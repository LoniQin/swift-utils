
//
//  UnwrappableTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import SwiftUtils

final class UnwrappableTestCase: XCTestCase {
    func testUnwrappable() {
        var a: Int?
        var b: Double?
        var c: String?
        a.unwrapped.assert.equal(0)
        b.unwrapped.assert.equal(0)
        c.unwrapped.assert.equal("")
        a = 1
        b = 2
        c = "3"
        a.assert.equal(1)
        b.assert.equal(2)
        c.assert.equal("3")
    }
}
