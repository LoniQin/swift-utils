
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
    
        let data = Data(0..<100)
        var md5 = MD5()
        md5.update(data)
        print(Array(md5.finalize()))
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
    
    func testSHA1() throws {
        for _ in 0..<10.thouthand {
            let data = Data(random: 100)
            var sha1 = SHA1()
            sha1.update(data)
            sha1.finalize().assert.equal(Digest.sha1.process(data))
        }
        let largeData = Data(random: 65536)
        var sha1 = SHA1()
        sha1.update(largeData)
        sha1.finalize().assert.equal(Digest.sha1.process(largeData))
    }
    
    func testSHA1Performance() throws {
        try DebugLogger.default.measure {
            for _ in 0..<10.thouthand {
                let data = Data(random: 64)
                var sha1 = SHA1()
                sha1.update(data)
                _ = sha1.finalize()
            }
        }
        
        try DebugLogger.default.measure {
            for _ in 0..<10.thouthand {
                let data = Data(random: 64)
                _ = Digest.sha1.process(data)
            }
        }
    }

}
