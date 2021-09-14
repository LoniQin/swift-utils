
//
//  FileStorageTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import SwiftUtils

final class FileStorageTestCase: XCTestCase {
    
    struct User: Codable, Equatable {
        
        let name: String
        
        let age: Int
        
        let weight: Double
        
    }
    
    func testFileStorage() throws {
        print(dataPath())
        let key = "12345678921434578921112345678932"
        let iv = "1234567891234567"
        let filePath = dataPath() / "encripted_user"
        let user = User(name: "Lonnie", age: 28, weight: 70)
        let fileStorage = try FileStorage(path: filePath, encodeOptions: .aes(.encrypt, key: key, iv: iv), decodeOptions: .aes(.decrypt, key: key, iv: iv), loadAndSaveImmediately: true)
        try fileStorage.set(user, for: "user")
        let anotherFileStore = try FileStorage(path: filePath, encodeOptions: .aes(.encrypt, key: key, iv: iv), decodeOptions: .aes(.decrypt, key: key, iv: iv))
        try anotherFileStore.load()
        let decodedUser: User? = try anotherFileStore.get("user")
        decodedUser.assert.notNil().equal(user)
    }

    func testFileStorage2() throws {
        let key = Data(random: 32)
        let iv = Data(random: 16)
        let filePath = dataPath() / "encripted_user_2"
        let user = User(name: "Lonnie", age: 28, weight: 70)
        var fileStorage = try FileStorage(path: filePath, encodeOptions: .aes(.encrypt, key: key, iv: iv), decodeOptions: .aes(.decrypt, key: key, iv: iv))
        fileStorage.user = user
        try fileStorage.save()
        let anotherFileStore = try FileStorage(path: filePath, encodeOptions: .aes(.encrypt, key: key, iv: iv), decodeOptions: .aes(.decrypt, key: key, iv: iv))
        try anotherFileStore.load()
        anotherFileStore.user.assert.notNil().equal(user)
    }
    
    func testFileStorage3() throws {
        let filePath = dataPath()  / "values.json"
        struct User: Codable, Equatable {
            let name: String
        }
        let storage = try FileStorage(path: filePath)
        let user = User(name: "Lonnie")
        try storage.set(user, for: "user")
        try storage.save()
        try user.assert.equal(storage.get("user"))
        let nextStorage = try FileStorage(path: filePath)
        try nextStorage.load()
        let nextUser: User = try nextStorage.get("user")
        user.assert.equal(nextUser)
    }
    
    func testFileStorageWithLargeData() throws {
        let key = Data(random: 32)
        let iv = Data(random: 16)
        let filePath = dataPath() / "numbers"
        let fileStorage = try FileStorage(path: filePath, encodeOptions: .aes(.encrypt, key: key, iv: iv), decodeOptions: .aes(.decrypt, key: key, iv: iv))
        try DebugLogger.default.measure(description: "Set 1 million numbers") {
            for i in 0..<1.million {
                try? fileStorage.set(i, for: i)
            }
        }
        try DebugLogger.default.measure(description: "Save data with AES algorithm") {
            try? fileStorage.save()
        }
        
        let anotherFileStorage = try FileStorage(path: filePath, encodeOptions: .aes(.encrypt, key: key, iv: iv), decodeOptions: .aes(.decrypt, key: key, iv: iv))
        try DebugLogger.default.measure(description: "Load data with AES algorithm") {
            try? anotherFileStorage.load()
        }
        var value: Int = 0
        try DebugLogger.default.measure(description: "Retrieve 1 million numbers") {
            for i in 0..<1.million {
                value = try anotherFileStorage.get(i)
                value.assert.equal(i)
            }
        }
    }
}
