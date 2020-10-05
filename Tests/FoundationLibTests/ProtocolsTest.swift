//
//  ProtocolsTest.swift
//  
//
//  Created by lonnie on 2020/10/2.
//
import XCTest
@testable import FoundationLib
import CommonCrypto
final class ProtocolsTest: XCTestCase {
    struct User: Codable {
        var phone: String
        var password: String
        var age: Int
    }
    
    func testDataStorageStrategy() throws {
        var defaults: DataStorage = UserDefaults.standard
        try test(with: &defaults)
        var cache: DataStorage = CacheStorage()
        try test(with: &cache)
    }
    
    func test(with storage: inout DataStorage) throws {
        storage.phone = "1"
        storage.password = "2"
        storage.phone.assert.equal("1")
        storage.password.assert.equal("2")
        
        var user = User(phone: "123456", password: "abc123", age: 24)
        try storage.set(user, for: "user")
        user = try storage.get("user")
        user.phone.assert.equal("123456")
        user.age.assert.equal(24)
        user.age.assert.notEqual(3833)
        user.password.assert.equal("abc123")
        user.password.assert.notEqual("11133")
        user = storage.user ?? User(phone: "", password: "", age: 0)
        user.phone.assert.equal("123456")
        user.age.assert.equal(24)
        user.age.assert.notEqual(3833)
        user.password.assert.equal("abc123")
        user.password.assert.notEqual("11133")
        
    }
    
}
