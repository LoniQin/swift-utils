
//
//  LocalizationTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import FoundationLib

final class LocalizationTestCase: XCTestCase {
    
    func testLocalization() {
        if let bundle = Bundle(path: dataPath() / "test.bundle") {
            let localization = Localization(tableName: "test", bundle: bundle)
            localization.string(for: "a").assert.equal("1")
            localization.string(for: "b").assert.equal("2")
            localization.string(for: "c").assert.equal("3")
            localization.a.assert.equal("1")
            localization.b.assert.equal("2")
            localization.c.assert.equal("3")
        }
    }
    
}
