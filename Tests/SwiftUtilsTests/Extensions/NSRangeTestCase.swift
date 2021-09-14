
//
//  NSRangeTestCase.swift
//
//
//  Created by lonnie on 2020/10/25.
//

import Foundation
import XCTest
@testable import SwiftUtils

final class NSRangeTestCase: XCTestCase {
    func testIsValid() {
        NSRange(location: NSNotFound, length: 1).isValid.assert.false()
        NSRange(location: -1, length: 1).isValid.assert.false()
        NSRange(location: 0, length: 1).isValid.assert.true()
        NSRange(location: 10, length: 0).isValid.assert.false()
    }
}
