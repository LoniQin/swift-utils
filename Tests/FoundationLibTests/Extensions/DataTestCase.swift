
//
//  DataTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import FoundationLib
final class DataTestCase: XCTestCase {
    
    func testInitWithHex() throws {
        let hex = "ffaaddbb1122"
        let data = try Data(hex: hex)
        data.hex.assert.equal(hex)
    }
    
    func testEncoding() throws {
        for encoding in FoundationLib.Encoding.allCases {
            let text = "aaffddcc11448899"
            let data = try text.data(encoding)
            try data.string(encoding).assert.equal(text)
        }
    }
    
}
