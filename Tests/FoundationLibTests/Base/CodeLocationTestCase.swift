
//
//  CodeLocationTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import FoundationLib

final class CodeLocationTestCase: XCTestCase {
    
    func testCodeLocation() {
        let location = CodeLocation()
        location.file.hasSuffix("CodeLocationTestCase.swift").assert.true()
        location.function.assert.equal("testCodeLocation()")
    }
    
}
