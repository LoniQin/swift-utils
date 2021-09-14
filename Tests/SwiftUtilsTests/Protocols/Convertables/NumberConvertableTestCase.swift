
//
//  NumberConvertableTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import SwiftUtils

final class NumberConvertableTestCase: XCTestCase {
    func testNumberConvertable() {
        2.int.assert.equal(2)
        2.uint.assert.equal(2)
        2.double.assert.equal(2)
        2.float.assert.equal(2)
        2.0.int.assert.equal(2)
        2.0.uint.assert.equal(2)
        2.0.double.assert.equal(2.0)
        2.0.float.assert.equal(2.0)
    }
}
