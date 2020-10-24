
//
//  NSRegularExpressionTestCase.swift
//
//
//  Created by lonnie on 2020/10/25.
//

import Foundation
import XCTest
@testable import FoundationLib

final class NSRegularExpressionTestCase: XCTestCase {
    
    func testNSRegularExpression() throws {
        try NSRegularExpression.urlExpression().validate("http://google.com").assert.true()
        try NSRegularExpression.urlExpression().validate("https://google.com").assert.true()
        try NSRegularExpression.urlExpression().validate("google.com").assert.false()
        try NSRegularExpression.urlExpression().validate("www.google.com").assert.false()
        try NSRegularExpression.urlExpression().validate("file://1.png").assert.true()
    }
    
}
