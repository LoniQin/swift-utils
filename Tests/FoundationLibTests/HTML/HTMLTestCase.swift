
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
    
    func testForEach() {
        ul {
            foreach([1, 2, 3, 4, 5]) { index in
                li("List \(index)")
            }
        }.description.assert.equal("<ul>\n\t<li>List 1</li>\n\t<li>List 2</li>\n\t<li>List 3</li>\n\t<li>List 4</li>\n\t<li>List 5</li>\n</ul>\n")
    }
    
    func testIf() {
        `if`(1 > 0).true {
            li("1 is greater than 0")
        }.false {
            li("1 is less than 0")
        }.description.assert.equal("<li>1 is greater than 0</li>\n")
    }
}
