
//
//  BuilderTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import SwiftUtils

final class BuilderTestCase: XCTestCase {
    
    func testBuilder() {
        // Usage
        class Car: Buildable {
            
            var numberOfWheels = 0
            
            var model = ""
            
        }
        
        let car = Car()
        car.builder.build {
            $0.numberOfWheels = 4
            $0.model = "Tesla"
        }
        car.numberOfWheels.assert.equal(4)
        car.model.assert.equal("Tesla")
        car.builder.with(\.numberOfWheels, 8).with(\.model, "BMW")
        car.numberOfWheels.assert.equal(8)
        car.model.assert.equal("BMW")
        
    }
    
}
