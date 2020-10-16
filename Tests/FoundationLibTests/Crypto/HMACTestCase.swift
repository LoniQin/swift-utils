
//
//  HMACTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import FoundationLib

final class HMACTestCase: XCTestCase {
    
    func testHMACSHA256() throws {
        let hmac = try HMAC(.sha256, key: "11111111111111111111".data(.hex))
        print("Result: \(try hmac.process(try "Hello world".data(.utf8)).string(.hex))")

    }
    
    func testHMAC() throws {
        let plainText = "Hello world"
        print("Plain Text: \(plainText)")
        for algorithm in HMAC.Algorithm.allCases {
            let hmac = try HMAC(algorithm, key: "11111111111111111111".data(.hex))
            print("HMAC " + String(describing: algorithm).uppercased() + ":", try hmac.process(plainText.data(.ascii)).string(.hex))
        }
    }
    
}
