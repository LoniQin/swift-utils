
//
//  NumericTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import SwiftUtils

final class NumericTestCase: XCTestCase {
    func testNumericExtension() {
        9.hundred.assert.equal(900)
        9.thouthand.assert.equal(9000)
        9.million.assert.equal(9000000)
        9.billion.assert.equal(9000000000)
    }
}
