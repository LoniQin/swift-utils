//
//  Assert.swift
//  
//
//  Created by lonnie on 2020/8/22.
//

import Foundation
import XCTest

struct Assert {
    
    func equal<T: Equatable>(_ lhs: T, _ rhs: T) {
        XCTAssertEqual(lhs, rhs)
    }
    
    func `true`(_ expression: Bool) {
        XCTAssertTrue(expression)
    }
    
    func `false`(_ expression: Bool) {
        XCTAssertFalse(expression)
    }
    
    func notNil(_ expression: Any?, message: String = "") {
        XCTAssertNotNil(expression, message)
    }
    
}


struct EquatibleAssert<T: Equatable> {
    
    let value: T
    
    let assert = Assert()
    
    func equal(_ another: T) {
        assert.equal(value, another)
    }
}

fileprivate let assert = Assert()

extension Equatable {
    
    var assert: EquatibleAssert<Self> { EquatibleAssert(value: self) }

}
