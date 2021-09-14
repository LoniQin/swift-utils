
//
//  ArrayBuilderTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import SwiftUtils

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
    
    func testArrayBuilder() {
        var array = Array {
            1
            2
            3
            4
            5
        }
        array.assert.equal([1, 2, 3, 4, 5])
        
        array.append {
            6
            7
            8
            9
            10
        }
        array.assert.equal([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
    }
    
}
