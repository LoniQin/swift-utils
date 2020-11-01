
//
//  HTMLTestCase.swift
//
//
//  Created by lonnie on 2020/11/1.
//

import Foundation
import XCTest
@testable import FoundationLib

final class HTMLTestCase: XCTestCase {
    func testHTML() {
        html {
            header {
                title("Hello world")
            }
            body {
                p("Hello world")
            }
        }.toHTML().assert.equal("<html>\n\t<header>\n\t\t<title>Hello world</title>\n\t</header>\n\t<body>\n\t\t<p>Hello world</p>\n\t</body>\n</html>\n")
    }
}
