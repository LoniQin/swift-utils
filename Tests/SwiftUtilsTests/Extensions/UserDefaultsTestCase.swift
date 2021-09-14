
//
//  UserDefaultsTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import SwiftUtils

final class UserDefaultsTestCase: XCTestCase {
    
    func testUserDefaults() throws {
        
        struct User: Codable, Equatable {
            let name: String
        }
        
        var storage = UserDefaults.standard
        let user = User(name: "Lonnie")
        try storage.load()
        try storage.set(user, for: "user")
        try storage.save()
        try user.assert.equal(storage.get("user"))
        storage.anotherUser = User(name: "Tom")
        storage.anotherUser.assert.equal(User(name: "Tom"))
    }
    
}
