
//
//  UIntTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import SwiftUtils

final class UIntTestCase: XCTestCase {
    
    func testNumberConvertable() {
        let value: UInt = 999
        value.int.assert.equal(999)
        value.float.assert.equal(999)
        value.double.assert.equal(999)
        value.uint.assert.equal(999)
    }
    
}
