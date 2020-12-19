
//
//  ArrayTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import FoundationLib

final class ArrayTestCase: XCTestCase {
    
    func testArrayExtension() {
        let array: [Any] = [1, 3, 5, "7", 9]
        do {
            let a: Int = try array.get(0)
            a.assert.equal(1)
            let b: String = try array.get(3)
            b.assert.equal("7")
            let c: Int? = array.get(0)
            c.assert.equal(1)
            let d: Int? = array.get(100)
            d.assert.equal(nil)
        } catch  {
            XCTFail()
        }
        do {
            let _ : Int = try array.get(3)
            XCTFail()
        } catch {
            
        }
    }
    
    func testSafelyInsert() {
        var items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        var succeed: Bool?
        items.safelyInsert(10, at: 1, succeed: &succeed)
        items.assert.equal([1, 10, 2, 3, 4, 5, 6, 7, 8, 9, 10])
        items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        items.safelyInsert(10, at: 0, succeed: &succeed)
        items.assert.equal([10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
        items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        items.safelyInsert(10, at: 10, succeed: &succeed)
        items.assert.equal([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10])
    }
    
    func testSafelyDelete() {
        var items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        items.safelyDelete(at: 8)
        items.assert.equal([1, 2, 3, 4, 5, 6, 7, 8, 10])
        items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        items.safelyDelete(at: 0)
        items.assert.equal([2, 3, 4, 5, 6, 7, 8, 9, 10])
        items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        items.safelyDelete(at: 9)
        items.assert.equal([1, 2, 3, 4, 5, 6, 7, 8, 9])
    }
    
    func testLocate() {
        let items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        items.locate(1).assert.equal(0)
        items.locate(10).assert.equal(9)
        items.locate(8).assert.equal(7)
        items.locate(100).assert.equal(-1)
    }
    
    func testReverse() {
        var items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        items.reverse(at: 0..<2)
        items.assert.equal([2, 1, 3, 4, 5, 6, 7, 8, 9, 10])
        items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        items.reverse(at: 0..<10)
        items.assert.equal([10, 9, 8, 7, 6, 5, 4, 3, 2, 1])
    }
    
    func testRemove() {
        var items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        items.remove(from: 3, to: 4)
        items.assert.equal([1, 2, 5, 6, 7, 8, 9, 10])
        items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        items.remove(from: 1, to: 9)
        items.assert.equal([10])
        items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        items.remove(from: 1, to: 10)
        items.assert.equal([])
        items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        items.remove(from: 2, to: 10)
        items.assert.equal([1])
    }
    
}
