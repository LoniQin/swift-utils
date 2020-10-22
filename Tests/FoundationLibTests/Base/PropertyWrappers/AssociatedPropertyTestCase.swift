
//
//  AssociatedPropertyTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import FoundationLib

final class AssociatedPropertyTestCase: XCTestCase {
    
    func testAssociatedProperty() {
        
        class Dog {
            @AssociatedProperty var name: String!
            @AssociatedProperty var age: Int!
            @AssociatedProperty var greet: (()->Void)?
            
        }
        
        let dog = Dog()
        dog.name = "Tom"
        var text = ""
        dog.greet = {
            print("Hello", terminator: "", to: &text)
        }
        dog.greet?()
        text.assert.equal("Hello")
        text = ""
        dog.greet = {
            print("Hello world", terminator: "", to: &text)
        }
        dog.greet?()
        text.assert.equal("Hello world")
        dog.age = 1
        dog.name.assert.equal("Tom")
        dog.age.assert.equal(1)
        dog.name = "Jack"
        dog.age = 2
        dog.name.assert.equal("Jack")
        dog.age.assert.equal(2)
    
    }
    
}
