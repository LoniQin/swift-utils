
//
//  DynamicMemberLookupableTestCase.swift
//
//
//  Created by lonnie on 2020/1/1.
//

import Foundation
import XCTest
@testable import FoundationLib

final class DynamicMemberLookupableTestCase: XCTestCase {

    func testDynamicMemberLookupable() {
        (1 + 1).assert.equal(2)
    }
}
