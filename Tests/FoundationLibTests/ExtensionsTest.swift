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
    func testNumericExtension() {
        9.hundred.assert.equal(900)
        9.thouthand.assert.equal(9000)
        9.million.assert.equal(9000000)
        9.billion.assert.equal(9000000000)
    }
}
