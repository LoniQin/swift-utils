
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
        // 1. Build HTML
        let node = html {
            header {
                title("Hello world")
            }
            body {
                p("Hello world")
            }
        }
        let value = "<html>\n\t<header>\n\t\t<title>Hello world</title>\n\t</header>\n\t<body>\n\t\t<p>Hello world</p>\n\t</body>\n</html>"
        // Convert to HTML string
        node.toHTML().assert.equal(value)
        print(node)
        // Write to file
        try node.write(to: dataPath() / "hello.html")
        try String(contentsOfFile: dataPath() / "hello.html").assert.equal(value)
    }
    
    func testForEach() {
        // 2. Control flow
        // 2.1 for node
        let node = ul {
            `for`(1..<6) {
                li("List \($0)")
            }
        }
        print(node)
        node.description.assert.equal("<ul>\n\t<li>List 1</li>\n\t<li>List 2</li>\n\t<li>List 3</li>\n\t<li>List 4</li>\n\t<li>List 5</li>\n</ul>")
    }
    
    func testIf() {
        // 2.2 if node
        let a = 1
        let b = 2
        let node = `if`(a > b) {
            li("\(a) is larger then \(b)")
        }.else {
            li("\(a) is not larger then \(b)")
        }
        print(node)
        node.description.assert.equal("<li>1 is not larger then 2</li>")
    }
}
