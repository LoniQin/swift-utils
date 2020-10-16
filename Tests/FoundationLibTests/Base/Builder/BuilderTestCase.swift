
//
//  BuilderTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import FoundationLib

final class BuilderTestCase: XCTestCase {
    
    func testSample() {
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
        
    }
}
