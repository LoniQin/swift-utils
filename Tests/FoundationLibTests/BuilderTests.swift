//
//  BuildderTests.swift
//  
//
//  Created by lonnie on 2020/9/26.
//

import Foundation
import XCTest
@testable import FoundationLib

final class BuildderTests: XCTestCase {
    
    
    func testBuilderBlock() {
        class Dog: Buildable {
            
            typealias BuilderClass = Builder<Dog>
            
            var name = "jack"
            
            var age = 1
            
        }
        
        let dog = Dog()
        dog.builder.build {
            $0.name = "Tom"
            $0.age = 8
        }
        dog.age.assert.equal(8)
        dog.name.assert.equal("Tom")
        dog.builder.with(\.age, 16).with(\.name, "Mary")
        dog.age.assert.equal(16)
        dog.name.assert.equal("Mary")
    }
}
