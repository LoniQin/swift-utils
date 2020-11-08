
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
        """
        <html>
        \t<header>
        \t\t<title>Hello world</title>
        \t</header>
        \t<body>
        \t\t<p>Hello world</p>
        \t</body>
        </html>
        """.assert.equal(node.toHTML())
        // Write to file
        try node.write(to: dataPath() / "hello.html")
        try String(contentsOfFile: dataPath() / "hello.html").assert.equal(node.toHTML())
        
        // 1.1 Set html attributes
        let node2 = html {
            header {
                title("Hello world")
            }
            body {
                // use chained method
                p("Paragraph 1").id("p_1").class("class_1")
                // Set up attributes dynamically
                p("Paragraph 2")(id: "p_2", class: "class_2")
            }
        }
        print(node2)
        """
        <html>
        \t<header>
        \t\t<title>Hello world</title>
        \t</header>
        \t<body>
        \t\t<p class="class_1" id="p_1">Paragraph 1</p>
        \t\t<p class="class_2" id="p_2">Paragraph 2</p>
        \t</body>
        </html>
        """.assert.equal(node2.toHTML())
    }
    
    func testForEach() {
        // 2. Control flow
        // 2.1 For node
        let node = ul {
            For(1..<6) {
                li("List \($0)")
            }
        }
        print(node)
        node.description.assert.equal("<ul>\n\t<li>List 1</li>\n\t<li>List 2</li>\n\t<li>List 3</li>\n\t<li>List 4</li>\n\t<li>List 5</li>\n</ul>")
    }
    
    func testIf() {
        // 2.2 If node
        var a = 1
        var b = 2
        let node = If(a > b) {
            li("\(a) is larger than \(b)")
        }.elif(a < b) {
            li("\(a) is less than \(b)")
        }.else {
            li("\(a) is equal to \(b)")
        }
        node.description.assert.equal("<li>1 is less than 2</li>")
        a = 5
        b = 4
        node.description.assert.equal("<li>5 is larger than 4</li>")
        a = 4
        b = 4
        node.description.assert.equal("<li>4 is equal to 4</li>")
    }
    
    func testSwitch() {
        // 2.3 Switch node
        var i = 2
        let node = Switch(i)
            .case(1, p("Result is 1"))
            .case(2, p("Result is 2"))
            .case(3, p("Result is 3"))
            .case(4, p("Result is 4"))
            .case(5, p("Result is 5"))
            .default(p("Other result"))
        node.description.assert.equal("<p>Result is 2</p>")
        i = 10
        node.description.assert.equal("<p>Other result</p>")
    }
    
    func testLink() {
        let node = FoundationLib.link(href: "style.css")
        node.description.assert.equal("<link href=\"style.css\" rel=\"stylesheet\" type=\"text/css\"/>")
    }
    
    func testA() {
        a(content: "Click me", href: "http://www.sample.com").description.assert.equal("<a href=\"http://www.sample.com\">Click me</a>")
    }
    
    func testAbbr() {
        
        "\(abbr(content: "US", title: "The United states"))".assert.equal("<abbr title=\"The United states\">US</abbr>")
    }
    
    func testTitle() {
        let node = title("hello")
        node.description.assert.equal("<title>hello</title>")
    }
    
    func testNoScript() {
        noscript("Hello").description.assert.equal("<noscript>Hello</noscript>")
    }
}
