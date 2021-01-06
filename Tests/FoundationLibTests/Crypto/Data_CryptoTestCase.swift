
//
//  Data_CryptoTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import FoundationLib

final class Data_CryptoTestCase: XCTestCase {
    
    func testMD5() throws {
        for _ in 0..<10.thouthand {
            let data = Data(random: 64)
            var md5 = MD5()
            md5.update(data)
            md5.final().hex.assert.equal(Digest.md5.process(data).hex)
        }
    }
    
}
