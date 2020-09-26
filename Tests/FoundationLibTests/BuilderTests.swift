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
    
    class Dog: NSObject, Buildable {
        
        typealias BuilderClass = Builder<Dog>
        
        var name = "jack"
        var age = 1
    }
    func testBuilderBlock() {
        let dog = Dog()
        dog.builder.build {
            $0.name = "Tom"
            $0.age = 8
        }
        dog.age.assert.equal(8)
        dog.name.assert.equal("Tom")
        dog.builder.set(\.age, 16).set(\.name, "Mary")
        dog.age.assert.equal(16)
        dog.name.assert.equal("Mary")
    }
}
