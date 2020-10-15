
//
//  DefaultTestCase.swift
//
//
//  Created by lonnie on 2020/1/1.
//

import Foundation
import XCTest
@testable import FoundationLib

final class DefaultTestCase: XCTestCase {

    func testDefault() {
        (1 + 1).assert.equal(2)
    }
}
