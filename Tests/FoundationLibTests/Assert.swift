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
    
    func notNil() {
        Assert.notNil(value)
    }
    
    func fail(_ error: Error) {
        Assert.fail(error)
    }
}
extension AssertProtocol where Element: Equatable {
    
    func equal(_ another: Element) {
        Assert.equal(value, another)
    }
    
    func notEqual(_ another: Element) {
        Assert.notEqual(value, another)
    }
    
}

extension AssertProtocol where Element == Bool {
    
    func `true`() {
        Assert.true(value)
    }
    
    func `false`() {
       Assert.false(value)
    }
    
}

extension AssertProtocol where Element: Comparable {
    func greaterThan(_ another: Element) {
        Assert.greaterThan(value, another)
    }
    
    func greaterThanOrEqual(_ another: Element) {
        Assert.greaterThanOrEqual(value, another)
    }
    
    func lessThan(_ another: Element) {
        Assert.lessThan(value, another)
    }
    
    func lessThanOrEqual(_ another: Element) {
        Assert.lessThanOrEqual(value, another)
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
