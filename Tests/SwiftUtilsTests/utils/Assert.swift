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
    
    public static func equal<T: Equatable>(_ lhs: T, _ rhs: T) {
        XCTAssertEqual(lhs, rhs)
    }
    
    public static func notEqual<T: Equatable>(_ lhs: T, _ rhs: T) {
        XCTAssertNotEqual(lhs, rhs)
    }
    
    public static func greaterThan<T: Comparable>(_ lhs: T, _ rhs: T) {
        XCTAssertGreaterThan(lhs, rhs)
    }
    
    public static func greaterThanOrEqual<T: Comparable>(_ lhs: T, _ rhs: T) {
        XCTAssertGreaterThanOrEqual(lhs, rhs)
    }
    
    public static func lessThan<T: Comparable>(_ lhs: T, _ rhs: T) {
        XCTAssertLessThan(lhs, rhs)
    }
    
    public static func lessThanOrEqual<T: Comparable>(_ lhs: T, _ rhs: T) {
        XCTAssertLessThanOrEqual(lhs, rhs)
    }
    
    public static func `true`(_ expression: Bool) {
        XCTAssertTrue(expression)
    }
    
    public static func `false`(_ expression: Bool) {
        XCTAssertFalse(expression)
    }
    
    public static func notNil(_ expression: Any?, message: String = "") {
        XCTAssertNotNil(expression, message)
    }
    
    public static func fail(_ error: Error) {
        XCTFail(error.localizedDescription)
    }
}

protocol AssertProtocol {
    
    associatedtype Element
    
    var value: Element { get } 
    
}

extension AssertProtocol {
    
    @discardableResult
    func notNil() -> Self {
        Assert.notNil(value)
        return self
    }
    
    @discardableResult
    func fail(_ error: Error) -> Self {
        Assert.fail(error)
        return self
    }
}
extension AssertProtocol where Element: Equatable {
    
    @discardableResult
    func equal(_ another: Element) -> Self {
        Assert.equal(value, another)
        return self
    }
    
    @discardableResult
    func notEqual(_ another: Element) -> Self {
        Assert.notEqual(value, another)
        return self
    }
    
}

extension AssertProtocol where Element == Bool {
    
    @discardableResult
    func `true`() -> Self {
        Assert.true(value)
        return self
    }
    
    @discardableResult
    func `false`() -> Self {
        Assert.false(value)
        return self
    }
    
}

extension AssertProtocol where Element == Double {
    
    @discardableResult
    func approximatelyEqualTo(_ value: Double) -> Self {
        Assert.lessThan(abs(self.value - value), 1e-3)
        return self
    }
}

extension AssertProtocol where Element: Comparable {
    
    @discardableResult
    func greaterThan(_ another: Element) -> Self {
        Assert.greaterThan(value, another)
        return self
    }
    
    @discardableResult
    func greaterThanOrEqual(_ another: Element) -> Self {
        Assert.greaterThanOrEqual(value, another)
        return self
    }
    
    @discardableResult
    func lessThan(_ another: Element) -> Self {
        Assert.lessThan(value, another)
        return self
    }
    
    @discardableResult
    func lessThanOrEqual(_ another: Element) -> Self {
        Assert.lessThanOrEqual(value, another)
        return self
    }
}

public struct EquatableAssert<T: Equatable>: AssertProtocol {
    
    public let value: T

}

public struct ComparableAssert<T: Comparable>: AssertProtocol {
    
    public let value: T

}

public extension Equatable {
    
    var assert: EquatableAssert<Self> { EquatableAssert(value: self) }

}

public extension Comparable {
    
    var assert: ComparableAssert<Self> { ComparableAssert(value: self) }

}

#endif
