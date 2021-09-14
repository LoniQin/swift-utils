
//
//  DispatchQueueTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import SwiftUtils

final class DispatchQueueTestCase: XCTestCase {
    
    func testDispatchQueue() throws {
        let exp = self.expectation(description: #function)
        var value = 1
        value = try DispatchQueue.sync(onMain: {
            value + 1
        })
        DispatchQueue.main.after(1.0) {
            value += 5
            exp.fulfill()
        }
        waitForExpectations(timeout: 1.1) { (error) in
            value.assert.equal(7)
        }
        try 2.assert.equal(DispatchQueue.sync { 1 + 1 })
    }
    
}
