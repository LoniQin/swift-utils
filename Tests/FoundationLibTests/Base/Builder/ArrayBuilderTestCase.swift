
//
//  ArrayBuilderTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import FoundationLib

final class ArrayBuilderTestCase: XCTestCase {
    
    func testArrayWithOneItem() {
        // Create an array with one element
        let array: [Int] = Array {
            1
        }
        array.assert.equal([1])
    }
    
    func testArrayWithMoreThanOneItem() {
        // Create an array with more than one element
        let array: [Int] = Array {
            1
            2
            3
        }
        array.assert.equal([1, 2, 3])
    }
    
}
