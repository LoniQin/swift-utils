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
    
    public func notEqual<T: Equatable>(_ lhs: T, _ rhs: T) {
        XCTAssertNotEqual(lhs, rhs)
    }
    
    public func greaterThan<T: Comparable>(_ lhs: T, _ rhs: T) {
        XCTAssertGreaterThan(lhs, rhs)
    }
    
    public func greaterThanOrEqual<T: Comparable>(_ lhs: T, _ rhs: T) {
        XCTAssertGreaterThanOrEqual(lhs, rhs)
    }
    
    public func lessThan<T: Comparable>(_ lhs: T, _ rhs: T) {
        XCTAssertLessThan(lhs, rhs)
    }
    
    public func lessThanOrEqual<T: Comparable>(_ lhs: T, _ rhs: T) {
        XCTAssertLessThanOrEqual(lhs, rhs)
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


public struct EquatableAssert<T: Equatable> {
    
    public let value: T
    
    public let assert = Assert()
    
    public func equal(_ another: T) {
        assert.equal(value, another)
    }
    
    public func notEqual(_ another: T) {
        assert.notEqual(value, another)
    }
    
}

extension EquatableAssert where T == Bool {
    
    public func `true`() {
        assert.equal(value, true)
    }
    
    public func `false`() {
        assert.equal(value, false)
    }
    
}


public extension Equatable {
    
    var assert: EquatableAssert<Self> { EquatableAssert(value: self) }

}

#endif
