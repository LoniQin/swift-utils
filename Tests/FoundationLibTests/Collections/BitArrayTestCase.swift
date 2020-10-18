
//
//  BitArrayTestCase.swift
//
//
//  Created by lonnie on 2020/10/18.
//

import Foundation
import XCTest
@testable import FoundationLib

final class BitArrayTestCase: XCTestCase {
    
    func testBitArray() throws {
        let bitArray = BitArray(0..<1000)
        for i in 0..<1000 {
            try bitArray.add(i)
        }
        for i in 0..<1000 {
            bitArray.contains(i).assert.true()
        }
        for i in 0..<1000 {
            try bitArray.remove(i)
        }
        for i in 0..<1000 {
            bitArray.contains(i).assert.false()
        }
    }
    
}
