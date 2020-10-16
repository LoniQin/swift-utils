
//
//  DigestTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import FoundationLib

final class DigestTestCase: XCTestCase {
    
    func testDigests() {
        let plainText = "hello world"
        print("Plain text: \(plainText)")
        for digest in Digest.allCases {
            let digested = digest.process(plainText.data(using: .utf8)!)
            print("\(digest):\(digested.hex)")
            XCTAssert(digested.count == digest.length)
        }
    }
    
}
