
//
//  DataStoreManagerTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import FoundationLib

final class DataStoreManagerTestCase: XCTestCase {
    
    func testStorageManager() {
        
        struct User: Codable, Equatable {
            var name: String
        }
        
        let storageManager = DataStoreManager(storage: UserDefaults.standard)
        do {
            try storageManager.load()
            let a = User(name: "Tom")
            try storageManager.set(a, for: "user")
            try a.assert.equal(storageManager.get("user"))
            try storageManager.save()
            XCTAssert(try DataStoreManager(strategy: .memory).storage is DictionaryStorage)
            XCTAssert(try DataStoreManager(strategy: .userDefaults(suiteName: "hello")).storage is UserDefaults)
            XCTAssert(try DataStoreManager(strategy: .nsCache).storage is CacheStorage)
            XCTAssert(try DataStoreManager(strategy: .file(path: "a.json")).storage is FileStorage)
            
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
}
