//
//  StorageTests.swift
//  
//
//  Created by lonnie on 2020/10/6.
//

import XCTest
@testable import FoundationLib

final class StorageTests: XCTestCase {
    
    struct User: Codable, Equatable {
        
        let name: String
        
        let age: Int
        
        let weight: Double
        
    }
    
    func testFileStorage() throws {
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
    
    func testFileStorageWithLargeData() throws {
        let key = Data(random: 32)
        let iv = Data(random: 16)
        let filePath = dataPath() / "numbers"
        let fileStorage = try FileStorage(path: filePath, encodeOptions: .aes(.encrypt, key: key, iv: iv), decodeOptions: .aes(.decrypt, key: key, iv: iv))
        try DebugLogger.default.measure(desc: "Set 1 million numbers") {
            for i in 0..<1.million {
                try? fileStorage.set(i, for: i)
            }
        }
        try DebugLogger.default.measure(desc: "Save data with AES algorithm") {
            try? fileStorage.save()
        }
        
        let anotherFileStorage = try FileStorage(path: filePath, encodeOptions: .aes(.encrypt, key: key, iv: iv), decodeOptions: .aes(.decrypt, key: key, iv: iv))
        try DebugLogger.default.measure(desc: "Load data with AES algorithm") {
            try? anotherFileStorage.load()
        }
        var value: Int = 0
        try DebugLogger.default.measure(desc: "Retrieve 1 million numbers") {
            for i in 0..<1.million {
                value = try anotherFileStorage.get(i)
                value.assert.equal(i)
            }
        }
    }
    
    func testFileStorageWithCompressionAndAES() throws {
        try CompressionAlogrithm.allCases.forEach { (algorithm) in
            print("Test compression algorithm: \(algorithm)")
            let key = Data(random: 32)
            let iv = Data(random: 16)
            let filePath = dataPath() / "numbers.\(algorithm)"
            let fileStorage = try FileStorage(path: filePath, encodeOptions: .aes(.encrypt, key: key, iv: iv), decodeOptions: .aes(.decrypt, key: key, iv: iv), compresssionAlgorithm: algorithm)
            try DebugLogger.default.measure(desc: "Set 1 million numbers") {
                for i in 0..<1.million {
                    try fileStorage.set(i, for: i)
                }
            }
            try DebugLogger.default.measure(desc: "Save data with AES and \(algorithm) compression") {
                try fileStorage.save()
            }
            let anotherFileStorage = try FileStorage(path: filePath, encodeOptions: .aes(.encrypt, key: key, iv: iv), decodeOptions: .aes(.decrypt, key: key, iv: iv), compresssionAlgorithm: algorithm)
            try DebugLogger.default.measure(desc: "Load data with AES algorithm and \(algorithm) compression") {
                try anotherFileStorage.load()
            }
            var value: Int = 0
            try DebugLogger.default.measure(desc: "Retrieve 1 million numbers with AES and \(algorithm) compression") {
                for i in 0..<1.thouthand {
                    value = try anotherFileStorage.get(i)
                    value.assert.equal(i)
                }
            }
        }
    }
    
    func testFileStorageWithCompression() throws {
        try CompressionAlogrithm.allCases.forEach { (algorithm) in
            let quantity = 1.thouthand
            print("Test compression algorithm: \(algorithm)")
            let filePath = dataPath() / "numbers2.\(algorithm)"
            let fileStorage = try FileStorage(path: filePath, compresssionAlgorithm: algorithm)
            try DebugLogger.default.measure(desc: "Set \(quantity) numbers") {
                for i in 0..<quantity {
                    try fileStorage.set(i, for: i)
                }
            }
            try DebugLogger.default.measure(desc: "Save data with AES and \(algorithm) compression") {
                try fileStorage.save()
            }
            let anotherFileStorage = try FileStorage(path: filePath, compresssionAlgorithm: algorithm)
            try DebugLogger.default.measure(desc: "Load data with AES algorithm and \(algorithm) compression") {
                try anotherFileStorage.load()
            }
            var value: Int = 0
            try DebugLogger.default.measure(desc: "Retrieve 1 million numbers with AES and \(algorithm) compression") {
                for i in 0..<quantity {
                    value = try anotherFileStorage.get(i)
                    value.assert.equal(i)
                }
            }
        }
    }
    
}
