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
    
}
