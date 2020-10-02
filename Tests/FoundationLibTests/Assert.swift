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
    
    func fail(_ error: Error) {
        XCTFail(error.localizedDescription)
    }
}

protocol AssertProtocol {
    
    associatedtype Element
    
    var value: Element { get }
    
    var assert: Assert { get }
    
}

extension AssertProtocol {
    
    func notNil() {
        assert.notNil(value)
    }
    
    func fail(_ error: Error) {
        assert.fail(error)
    }
}
extension AssertProtocol where Element: Equatable {
    
    func equal(_ another: Element) {
        assert.equal(value, another)
    }
    
    func notEqual(_ another: Element) {
        assert.notEqual(value, another)
    }
    
}

extension AssertProtocol where Element == Bool {
    
    func `true`() {
        assert.true(value)
    }
    
    func `false`() {
       assert.false(value)
    }
    
}

extension AssertProtocol where Element: Comparable {
    func greaterThan(_ another: Element) {
        assert.greaterThan(value, another)
    }
    
    func greaterThanOrEqual(_ another: Element) {
        assert.greaterThanOrEqual(value, another)
    }
    
    func lessThan(_ another: Element) {
        assert.lessThan(value, another)
    }
    
    func lessThanOrEqual(_ another: Element) {
        assert.lessThanOrEqual(value, another)
    }
}


public struct EquatableAssert<T: Equatable>: AssertProtocol {
    
    public let value: T
    
    public let assert = Assert()

}

public struct ComparableAssert<T: Comparable>: AssertProtocol {
    
    public let value: T
    
    public let assert = Assert()

}

public extension Equatable {
    
    var assert: EquatableAssert<Self> { EquatableAssert(value: self) }

}

public extension Comparable {
    
    var assert: ComparableAssert<Self> { ComparableAssert(value: self) }

}

#endif
