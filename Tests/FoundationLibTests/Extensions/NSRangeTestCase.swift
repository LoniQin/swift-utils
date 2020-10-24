
//
//  NSRangeTestCase.swift
//
//
//  Created by lonnie on 2020/10/25.
//

import Foundation
import XCTest
@testable import FoundationLib

final class NSRangeTestCase: XCTestCase {
    func testIsValid() {
        var range = NSRange(location: NSNotFound, length: 1)
        range.isValid.assert.true()
    }
}
