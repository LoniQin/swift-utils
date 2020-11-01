
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
    func testHTML() throws {
        let htmlPage = html {
            header {
                title("Hello world")
            }
            body {
                p("Hello world")
            }
        }
        let value = "<html>\n\t<header>\n\t\t<title>Hello world</title>\n\t</header>\n\t<body>\n\t\t<p>Hello world</p>\n\t</body>\n</html>\n"
        htmlPage.toHTML().assert.equal(value)
        try htmlPage.write(to: dataPath() / "hello.html")
        try String(contentsOfFile: dataPath() / "hello.html").assert.equal(value)
    }
}
