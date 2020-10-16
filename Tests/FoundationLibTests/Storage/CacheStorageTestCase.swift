
//
//  CacheStorageTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import FoundationLib

final class CacheStorageTestCase: XCTestCase {
    
    func testNSCacheStorage() {
        let storage = CacheStorage.default
        do {
            try storage.set(1, for: "key")
            let value: Int = try storage.get("key")
            value.assert.equal(1)
        } catch {
            XCTFail()
        }
        
        do {
            let obj: Int? = nil
            try storage.set(obj, for: "key")
            let _: Int = try storage.get("key")
            XCTFail()
        } catch {
            
        }
    }
    
}
