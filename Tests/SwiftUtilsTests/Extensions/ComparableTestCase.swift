
//
//  ComparableTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import SwiftUtils

final class ComparableTestCase: XCTestCase {
    func testSample() {
        1.compareTo(2).assert.equal(-1)
        2.compareTo(2).assert.equal(0)
        2.compareTo(1).assert.equal(1)
    }
}
