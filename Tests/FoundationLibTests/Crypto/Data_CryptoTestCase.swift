
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
            md5.finalize().assert.equal(Digest.md5.process(data))
        }

        let data = Data(random: 65536)
        var md5 = MD5()
        md5.update(data)
        md5.finalize().assert.equal(Digest.md5.process(data))
    }
    
    func testMD5Performance() throws {
        try DebugLogger.default.measure {
            for _ in 0..<10.thouthand {
                let data = Data(random: 64)
                var md5 = MD5()
                md5.update(data)
                _ = md5.finalize()
            }
        }
        
        try DebugLogger.default.measure {
            for _ in 0..<10.thouthand {
                let data = Data(random: 64)
                _ = Digest.md5.process(data)
            }
        }
    }
    
}
