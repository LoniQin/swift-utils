
//
//  DictionaryStorageTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import SwiftUtils

final class DictionaryStorageTestCase: XCTestCase {
    
    func testDictionaryStorage() throws {
        struct User: Codable, Equatable {
            let name: String
        }
        let storage = DictionaryStorage()
        let user = User(name: "Lonnie")
        try storage.load()
        try storage.set(user, for: "user")
        try storage.save()
        try user.assert.equal(storage.get("user"))
    }
    
}
