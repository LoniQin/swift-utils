//
//  Assert.swift
//  
//
//  Created by lonnie on 2020/8/22.
//

import Foundation
#if canImport(XCTest)
import XCTest

public struct Assert {
    
    public func equal<T: Equatable>(_ lhs: T, _ rhs: T) {
        XCTAssertEqual(lhs, rhs)
    }
    
    public func `true`(_ expression: Bool) {
        XCTAssertTrue(expression)
    }
    
    public func `false`(_ expression: Bool) {
        XCTAssertFalse(expression)
    }
    
    public func notNil(_ expression: Any?, message: String = "") {
        XCTAssertNotNil(expression, message)
    }
    
}


public struct EquatibleAssert<T: Equatable> {
    
    public let value: T
    
    public let assert = Assert()
    
    public func equal(_ another: T) {
        assert.equal(value, another)
    }
}

public extension Equatable {
    
    var assert: EquatibleAssert<Self> { EquatibleAssert(value: self) }

}

#endif
