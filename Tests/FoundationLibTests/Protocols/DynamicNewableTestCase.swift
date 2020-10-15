
//
//  DynamicNewableTestCase.swift
//
//
//  Created by lonnie on 2020/1/1.
//

import Foundation
import XCTest
@testable import FoundationLib

final class DynamicNewableTestCase: XCTestCase {

    func testDynamicNewable() {
        (1 + 1).assert.equal(2)
    }
}
