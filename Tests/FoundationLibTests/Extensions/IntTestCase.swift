
//
//  IntTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import FoundationLib

final class IntTestCase: XCTestCase {
    
    func testInt() {
        let a = 1
        a.int.assert.equal(1)
        a.float.assert.equal(1)
        a.double.assert.equal(1)
        a.uint.assert.equal(1)
        99999.toBinaryString().assert.equal("11000011010011111")
        var value = 3567
        value.increasing().assert.equal(3568)
        value.decreasing().assert.equal(3567)
        
    }
    
}
