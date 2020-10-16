
//
//  RegexTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import FoundationLib

final class RegexTestCase: XCTestCase {
    
    func testRegex() {
        Regex.email.validate(text: "abc@def.com").assert.true()
        Regex.email.validate(text: "abcdef.com").assert.false()
        Regex.url.validate(text: "http://google.com").assert.true()
        Regex.url.validate(text: "https://google.com").assert.true()
        Regex.url.validate(text: "https://google").assert.false()
        Regex.ip.validate(text: "1.1.1.1").assert.true()
        Regex.ip.validate(text: "111.111.111").assert.false()
        
        let text = "Open website http://www.google.com"
        let result = Regex.scan(text: text)
        result.assert.equal([.url: ["http://www.google.com"]])
    }
    
}
