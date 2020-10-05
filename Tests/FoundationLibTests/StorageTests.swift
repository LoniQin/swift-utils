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
        let key = Data(random: 32)
        let iv = Data(random: 16)
        
        let user = User(name: "Lonnie", age: 28, weight: 70)
        let fileStorage = try FileStorage(path: dataPath() / "encripted_user.json", encodeOptions: .aes(.encrypt, key: key, iv: iv), decodeOptions: .aes(.decrypt, key: key, iv: iv))
        try fileStorage.set(user, for: "user")
        try fileStorage.save()
        let anotherFileStore = try FileStorage(path: dataPath() / "encripted_user.json", encodeOptions: .aes(.encrypt, key: key, iv: iv), decodeOptions: .aes(.decrypt, key: key, iv: iv))
        try anotherFileStore.load()
        let decodedUser: User? = try anotherFileStore.get("user")
        decodedUser.assert.notNil().equal(user)
    }

}
