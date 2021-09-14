
//
//  DefaultTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import SwiftUtils

final class DefaultTestCase: XCTestCase {
    
    func testDefault() {
        struct Item {
            
            @Default(2) var intValue: Int!
            
            @Default(3) var doubleValue: Double!
            
            @Default("Hello") var stringValue: String!
            
            @AssociatedProperty var associatedProperty: Int!
            
            @AssociatedProperty var associatedProperty2: String!
            
        }
        var item = Item()
        item.intValue.unwrapped.assert.equal(2)
        item.doubleValue.unwrapped.assert.equal(3)
        item.stringValue.unwrapped.assert.equal("Hello")
        item.intValue = 4
        item.doubleValue = 5
        item.stringValue = "World"
        item.intValue.unwrapped.assert.equal(4)
        item.doubleValue.unwrapped.assert.equal(5)
        item.stringValue.unwrapped.assert.equal("World")
        item.associatedProperty.assert.equal(nil)
        item.associatedProperty = 8
        item.associatedProperty.assert.equal(8)
        item.associatedProperty2.assert.equal(nil)
        item.associatedProperty2 = "Hello"
        item.associatedProperty2.assert.equal("Hello")
        item.associatedProperty2 = "Hello world"
        item.associatedProperty2.assert.equal("Hello world")
        
    }
    
}
