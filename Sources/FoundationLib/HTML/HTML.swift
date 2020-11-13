//
//  HTML.swift
//  
//
//  Created by lonnie on 2020/11/1.
//

import Foundation
@dynamicCallable
open class HTMLNode: NSObject {
    
    public var name: String
    
    public var contents: [String] = []
    
    public var attributes: [String: Any] = [:]
    
    public var children: [HTMLNode] = []
    
    @discardableResult
    public func dynamicallyCall(withKeywordArguments arguments: [String: Any]) -> HTMLNode {
        for item in arguments {
            let key = item.key.replacingOccurrences(of: "_", with: "-")
            attributes[key] = item.value
        }
        return self
    }
    
    public init(
        name: String,
        @ArrayBuilder _ builder: () -> [HTMLNode] = { [HTMLNode]() }) {
        self.name = name
        self.contents = []
        self.attributes = [:]
        self.children = builder()
    }
    
    public func toHTML(level: Int = 0) -> String {
        let contents = self.contents.filter { !$0.isEmpty }
        var items = [String]()
        var htmlTagAttribute = ""
        if !attributes.isEmpty {
            htmlTagAttribute += " \(attributes.htmlTagAttribute())"
        }
        if contents.count == 0 && children.count == 0 {
            items.append(level.tab + "<\(name)\(htmlTagAttribute)/>")
        } else {
            items.append(level.tab + "<\(name)\(htmlTagAttribute)>")
            if contents.count == 1 && children.count == 0 {
                items[items.count - 1].append("\(contents[0])</\(name)>")
            } else {
                for item in contents {
                    items.append((level + 1).tab + item)
                }
                for child in children {
                    items.append(child.toHTML(level: level + 1))
                }
                items.append(level.tab + "</\(name)>")
            }
        }
        return items.joined(separator: "\n")
    }
    
    public func write(to path: String) throws {
        try toHTML().write(toFile: path, atomically: true, encoding: .utf8)
    }
    
    public func id(_ value: String) -> Self {
        attributes["id"] = value
        return self
    }
    
    public func `class`(_ value: String) -> Self {
        attributes["class"] = value
        return self
    }
    
    public func href(_ value: String) -> Self {
        attributes["href"] = value
        return self
    }
    
    public func src(_ value: String) -> Self {
        attributes["src"] = value
        return self
    }
    
    open override var description: String {
        toHTML(level: 0)
    }
    
}

public extension HTMLNode {
 
}

public class html: HTMLNode {
    public init(@ArrayBuilder _ builder: () -> [HTMLNode] = { [HTMLNode]() }) {
        super.init(name: "html", builder)
    }
}

public class head: HTMLNode {
    public init(@ArrayBuilder _ builder: () -> [HTMLNode] = { [HTMLNode]() }) {
        super.init(name: "head", builder)
    }
}

public class header: HTMLNode {
    public init(@ArrayBuilder _ builder: () -> [HTMLNode] = { [HTMLNode]() }) {
        super.init(name: "header", builder)
    }
}

public class meta: HTMLNode {
    public init(@ArrayBuilder _ builder: () -> [HTMLNode] = { [HTMLNode]() }) {
        super.init(name: "meta", builder)
    }
}

public class script: HTMLNode {
    public init(@ArrayBuilder _ builder: () -> [HTMLNode] = { [HTMLNode]() }) {
        super.init(name: "script", builder)
    }
}

public class link: HTMLNode {
    
    public init(href: String) {
        super.init(name: "link")
        self(rel: "stylesheet", type: "text/css", href: href)
    }
    
}

public class title: HTMLNode {
    public init(_ content: String, @ArrayBuilder _ builder: () -> [HTMLNode] = { [HTMLNode]() }) {
        super.init(name: "title", builder)
        self.contents = [content]
    }
}

public class body: HTMLNode {
    public init(@ArrayBuilder _ builder: () -> [HTMLNode] = { [HTMLNode]() }) {
        super.init(name: "body", builder)
    }
}

public class h1: HTMLNode {
    public init(_ content: String) {
        super.init(name: "h1")
        self.contents = [content]
    }
}

public class h2: HTMLNode {
    public init(_ content: String) {
        super.init(name: "h2")
        self.contents = [content]
    }
}

public class h3: HTMLNode {
    public init(_ content: String) {
        super.init(name: "h3")
        self.contents = [content]
    }
}

public class h4: HTMLNode {
    public init(_ content: String) {
        super.init(name: "h4")
        self.contents = [content]
    }
}

public class h5: HTMLNode {
    public init(_ content: String) {
        super.init(name: "h5")
        self.contents = [content]
    }
}

public class h6: HTMLNode {
    public init(_ content: String = "") {
        super.init(name: "h6")
        self.contents = [content]
    }
}

public class p: HTMLNode {
    public init(_ content: String = "", @ArrayBuilder _ builder: () -> [HTMLNode] = { [HTMLNode]() }) {
        super.init(name: "p", builder)
        self.contents = [content]
    }
}

public class div: HTMLNode {
    public init(_ content: String = "", @ArrayBuilder _ builder: () -> [HTMLNode] = { [HTMLNode]() }) {
        super.init(name: "div", builder)
        self.contents = [content]
    }
}

public class span: HTMLNode {
    public init(_ content: String = "", @ArrayBuilder _ builder: () -> [HTMLNode] = { [HTMLNode]() }) {
        super.init(name: "span", builder)
        self.contents = [content]
    }
}

public class br: HTMLNode {
    public init() {
        super.init(name: "br")
    }
}

public class base: HTMLNode {
    public init() {
        super.init(name: "base")
    }
}

public class noscript: HTMLNode {
    public init(_ content: String) {
        super.init(name: "noscript")
        self.contents = [content]
    }
}

public class style: HTMLNode {
    public init() {
        super.init(name: "style")
    }
}

public class template: HTMLNode {
    public init() {
        super.init(name: "template")
    }
}

public class a: HTMLNode {
    public init(content: String, href: String) {
        super.init(name: "a")
        self.contents = [content]
        self.attributes["href"] = href
    }
}

public class abbr: HTMLNode {
    public init(content: String, title: String) {
        super.init(name: "abbr")
        self.contents = [content]
        self(title: title)
    }
}

public class address: HTMLNode {
    public init() {
        super.init(name: "address")
    }
}

public class area: HTMLNode {
    public init() {
        super.init(name: "area")
    }
}

public class article: HTMLNode {
    public init() {
        super.init(name: "article")
    }
}

public class aside: HTMLNode {
    public init() {
        super.init(name: "aside")
    }
}

public class audio: HTMLNode {
    public init() {
        super.init(name: "audio")
    }
}

public class b: HTMLNode {
    public init(_ content: String) {
        super.init(name: "b")
        self.contents = [content]
    }
} 

public class bdi: HTMLNode {
    public init() {
        super.init(name: "bdi")
    }
}

public class bdo: HTMLNode {
    public init() {
        super.init(name: "bdo")
    }
}

public class blockquote: HTMLNode {
    public init() {
        super.init(name: "blockquote")
    }
}

public class button: HTMLNode {
    public init() {
        super.init(name: "button")
    }
}

public class canvas: HTMLNode {
    public init() {
        super.init(name: "canvas")
    }
}

public class cite: HTMLNode {
    public init() {
        super.init(name: "cite")
    }
}

public class code: HTMLNode {
    public init() {
        super.init(name: "code")
    }
}

public class data: HTMLNode {
    public init() {
        super.init(name: "data")
    }
}

public class datalist: HTMLNode {
    public init() {
        super.init(name: "datalist")
    }
}

public class del: HTMLNode {
    public init() {
        super.init(name: "del")
    }
}

public class details: HTMLNode {
    public init() {
        super.init(name: "details")
    }
}

public class dfn: HTMLNode {
    public init() {
        super.init(name: "dfn")
    }
}

public class dl: HTMLNode {
    public init() {
        super.init(name: "dl")
    }
}

public class em: HTMLNode {
    public init() {
        super.init(name: "em")
    }
}

public class embed: HTMLNode {
    public init() {
        super.init(name: "embed")
    }
}

public class fieldset: HTMLNode {
    public init() {
        super.init(name: "fieldset")
    }
}

public class figure: HTMLNode {
    public init() {
        super.init(name: "figure")
    }
}

public class footer: HTMLNode {
    public init() {
        super.init(name: "footer")
    }
}

public class form: HTMLNode {
    public init() {
        super.init(name: "form")
    }
}

public class hr: HTMLNode {
    public init() {
        super.init(name: "hr")
    }
}

public class i: HTMLNode {
    public init() {
        super.init(name: "i")
    }
}

public class iframe: HTMLNode {
    public init() {
        super.init(name: "iframe")
    }
}

public class img: HTMLNode {
    public init() {
        super.init(name: "img")
    }
}

public class input: HTMLNode {
    public init() {
        super.init(name: "input")
    }
}

public class ins: HTMLNode {
    public init() {
        super.init(name: "ins")
    }
}

public class kbd: HTMLNode {
    public init() {
        super.init(name: "kbd")
    }
}

public class keygen: HTMLNode {
    public init() {
        super.init(name: "keygen")
    }
}

public class label: HTMLNode {
    public init() {
        super.init(name: "label")
    }
}

public class main: HTMLNode {
    public init() {
        super.init(name: "main")
    }
}

public class map: HTMLNode {
    public init() {
        super.init(name: "map")
    }
}

public class mark: HTMLNode {
    public init() {
        super.init(name: "mark")
    }
}

public class math: HTMLNode {
    public init(_ content: String) {
        super.init(name: "math")
        self.contents = [content]
        self(xmlns: "http://www.w3.org/1998/Math/MathML")
    }
}

public class menu: HTMLNode {
    public init() {
        super.init(name: "menu")
    }
}

public class meter: HTMLNode {
    public init() {
        super.init(name: "meter")
    }
}

public class nav: HTMLNode {
    public init(@ArrayBuilder _ builder: () -> [HTMLNode] = { [HTMLNode]() }) {
        super.init(name: "nav", builder)
    }
}

public class object: HTMLNode {
    public init() {
        super.init(name: "object")
    }
}

public class ol: HTMLNode {
    public init(@ArrayBuilder _ builder: () -> [HTMLNode] = { [HTMLNode]() }) {
        super.init(name: "ol", builder)
    }
}

public class output: HTMLNode {
    public init() {
        super.init(name: "output")
    }
}

public class picture: HTMLNode {
    public init() {
        super.init(name: "picture")
    }
}

public class pre: HTMLNode {
    public init() {
        super.init(name: "pre")
    }
}

public class progress: HTMLNode {
    public init() {
        super.init(name: "progress")
    }
}

public class q: HTMLNode {
    public init() {
        super.init(name: "q")
    }
}

public class ruby: HTMLNode {
    public init() {
        super.init(name: "ruby")
    }
}

public class s: HTMLNode {
    public init() {
        super.init(name: "s")
    }
}

public class samp: HTMLNode {
    public init() {
        super.init(name: "samp")
    }
}

public class section: HTMLNode {
    public init() {
        super.init(name: "section")
    }
}

public class select: HTMLNode {
    public init() {
        super.init(name: "select")
    }
}

public class small: HTMLNode {
    public init() {
        super.init(name: "small")
    }
}

public class strong: HTMLNode {
    public init() {
        super.init(name: "strong")
    }
}

public class sub: HTMLNode {
    public init() {
        super.init(name: "sub")
    }
}

public class sup: HTMLNode {
    public init() {
        super.init(name: "sup")
    }
}

public class svg: HTMLNode {
    public init() {
        super.init(name: "svg")
    }
}

public class table: HTMLNode {
    public init() {
        super.init(name: "table")
    }
}

public class textarea: HTMLNode {
    public init() {
        super.init(name: "textarea")
    }
}

public class time: HTMLNode {
    public init() {
        super.init(name: "time")
    }
}

public class u: HTMLNode {
    public init(_ content: String) {
        super.init(name: "u")
        contents = [content]
    }
}

public class ul: HTMLNode {
    public init(@ArrayBuilder _ builder: () -> [HTMLNode] = { [HTMLNode]() }) {
        super.init(name: "ul", builder)
    }
}

public class li: HTMLNode {
    public init(_ content: String = "", @ArrayBuilder _ builder: () -> [HTMLNode] = { [HTMLNode]() }) {
        super.init(name: "li", builder)
        self.contents = [content]
    }
}

public class `var`: HTMLNode {
    public init() {
        super.init(name: "var")
    }
}

public class video: HTMLNode {
    public init() {
        super.init(name: "video")
    }
}

public class wbr: HTMLNode {
    public init() {
        super.init(name: "wbr")
    }
}

public class text: HTMLNode {
    public init(_ content: String) {
        super.init(name: "text")
        self.contents = [content]
    }
}

public class For<T: Sequence>: HTMLNode {
    var sequence: [T.Element] = []
    var mapper: (T.Element) -> HTMLNode
    public init(_ sequence: T, _ mapper: @escaping (T.Element) -> HTMLNode) {
        self.sequence = sequence.map { $0 }
        self.mapper = mapper
        super.init(name: "")
    }
    
    public override func toHTML(level: Int = 0) -> String {
        sequence.map(mapper).map { (node) in
            node.toHTML(level: level)
        }.joined(separator: "\n")
    }
}

public class List: HTMLNode {
    var builder: () -> [HTMLNode]
    public init(@ArrayBuilder _ builder: @escaping () -> [HTMLNode] = { [HTMLNode]() }) {
        self.builder = builder
        super.init(name: "")
    }
    
    public override func toHTML(level: Int = 0) -> String {
        builder().map { (node) in
            node.toHTML(level: level)
        }.joined(separator: "\n")
    }
}


public class If: HTMLNode {
    
    let condition: () -> Bool
    
    var trueBlock: () -> HTMLNode = { br() }
    
    struct ElseIf {
        var block: () -> Bool
        var node: () -> HTMLNode
    }
    
    var elseIfs: [ElseIf] = []
    
    var falseBlock: () -> HTMLNode = { br() }
    
    public init(
        _ condition: @autoclosure @escaping () -> Bool,
        _ trueBlock: @escaping ()->HTMLNode
    ) {
        self.condition = condition
        self.trueBlock = trueBlock
        super.init(name: "")
    }
    
    public func `else`(
        _ falseBlock: @escaping () -> HTMLNode
    ) -> Self {
        self.falseBlock = falseBlock
        return self
    }
    
    public func elif(
        _ condition: @autoclosure @escaping () -> Bool,
        _ block: @escaping () -> HTMLNode
    ) -> Self {
        self.elseIfs.append(.init(block: { condition() }, node: block))
        return self
    }
    
    public override func toHTML(
        level: Int = 0
    ) -> String {
        if condition() {
            return trueBlock().toHTML(level: level)
        } else {
            for elif in elseIfs {
                if elif.block() == true {
                    return elif.node().toHTML(level: level)
                }
            }
            return falseBlock().toHTML(level: level)
        }
    }
}

public class Switch<T: Equatable>: HTMLNode {
    
    let condition: () -> T
    
    struct Case {
        var item: () -> T
        var block: () -> HTMLNode
    }
    
    struct Default {
        var block: () -> HTMLNode
    }
    
    var cases: [Case] = []
    
    var defaultItem: Default?
    
    public init(
        _ condition: @autoclosure @escaping () -> T
    ) {
        self.condition = condition
        super.init(name: "")
    }
    
    public func `case`(_ item: @autoclosure @escaping () -> T,
                       _ block: @autoclosure @escaping  () -> HTMLNode) -> Self {
        cases.append(.init(item: { item() }, block: { block() } ))
        return self
    }
    
    public func `default`(_ block: @autoclosure @escaping  () -> HTMLNode) -> Self {
        defaultItem = Default(block: block)
        return self
    }
    
    public override func toHTML(level: Int = 0) -> String {
        for item in cases {
            if item.item() == condition() {
                return item.block().toHTML(level: level)
            }
        }
        return defaultItem?.block().toHTML(level: level) ?? ""
    }
    
}
