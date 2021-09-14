
//
//  FloatTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import SwiftUtils

final class FloatTestCase: XCTestCase {
    
    func testFloat() {
        let value: Float = 999
        value.int.assert.equal(999)
        value.float.assert.equal(999)
        value.double.assert.equal(999)
        value.uint.assert.equal(999)
    }
    
}
