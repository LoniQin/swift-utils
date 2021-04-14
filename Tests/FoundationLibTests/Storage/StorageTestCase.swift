//
//  FileStorageTestCase.swift
//  
//
//  Created by Lonnie on 2021/4/14.
//

import Foundation
import XCTest
@testable import FoundationLib

final class StorageTestCase: XCTestCase {
    
    struct User {
        
        @Storage("name", defaultValue: "") var name: String
        
        @Storage("age", defaultValue: 0)  var age: Int
        
        @Storage("weight", defaultValue: 0) var weight: Double
        
    }
    
    func testFStorage() throws {
        let user = User()
        user.age = 0
        user.name = ""
        user.weight = 0
        user.age.assert.equal(0)
        user.name.assert.equal("")
        user.weight.assert.equal(0)
        user.age = 8
        user.name = "Tom"
        user.weight = 12
        user.age.assert.equal(8)
        user.name.assert.equal("Tom")
        user.weight.assert.equal(12)
        
    }
}
