//
//  HTML.swift
//  
//
//  Created by lonnie on 2020/11/1.
//

import Foundation
@dynamicCallable
public class HTMLNode: NSObject {
    
    public var name: String
    
    public var contents: [String] = []
    
    public var attributes: [String: Any] = [:]
    
    public var children: [HTMLNode] = []
    
    public func dynamicallyCall(withKeywordArguments arguments: [String: Any]) -> HTMLNode {
        for item in arguments {
            attributes[item.key] = item.value
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
        var content = ""
        var htmlTagAttribute = ""
        if !attributes.isEmpty {
            htmlTagAttribute += " \(attributes.htmlTagAttribute())"
        }
        if contents.count == 0 && children.count == 0 {
            content.append(String(repeating: "\t", count: level) + "<\(name)\(htmlTagAttribute)/>\n")
            return content
        }
        content.append(String(repeating: "\t", count: level) + "<\(name)\(htmlTagAttribute)>")
        if contents.count == 1 && children.count == 0 {
            for item in contents {
                content += item
            }
            content.append("</\(name)>\n")
        } else {
            content.append("\n")
            for item in contents {
                content += String(repeating: "\t", count: level + 1) + "\(item)\n"
            }
            for child in children {
                content.append(child.toHTML(level: level + 1))
            }
            content.append(String(repeating: "\t", count: level) + "</\(name)>\n")
        }
        
        return content
    }
    
}

public class html: HTMLNode {
    public init(@ArrayBuilder _ builder: () -> [HTMLNode] = { [HTMLNode]() }) {
        super.init(name: "html", builder)
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
    public init(@ArrayBuilder _ builder: () -> [HTMLNode] = { [HTMLNode]() }) {
        super.init(name: "link", builder)
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
    public init(_ content: String, @ArrayBuilder _ builder: () -> [HTMLNode] = { [HTMLNode]() }) {
        super.init(name: "h1", builder)
        self.contents = [content]
    }
}
public class h2: HTMLNode {
    public init(_ content: String, @ArrayBuilder _ builder: () -> [HTMLNode] = { [HTMLNode]() }) {
        super.init(name: "h2", builder)
        self.contents = [content]
    }
}
public class h3: HTMLNode {
    public init(_ content: String, @ArrayBuilder _ builder: () -> [HTMLNode] = { [HTMLNode]() }) {
        super.init(name: "h3", builder)
        self.contents = [content]
    }
}
public class h4: HTMLNode {
    public init(_ content: String, @ArrayBuilder _ builder: () -> [HTMLNode] = { [HTMLNode]() }) {
        super.init(name: "h4", builder)
        self.contents = [content]
    }
}
public class h5: HTMLNode {
    public init(_ content: String, @ArrayBuilder _ builder: () -> [HTMLNode] = { [HTMLNode]() }) {
        super.init(name: "h5", builder)
        self.contents = [content]
    }
}
public class h6: HTMLNode {
    public init(_ content: String, @ArrayBuilder _ builder: () -> [HTMLNode] = { [HTMLNode]() }) {
        super.init(name: "h6", builder)
        self.contents = [content]
    }
}
public class p: HTMLNode {
    public init(_ content: String, @ArrayBuilder _ builder: () -> [HTMLNode] = { [HTMLNode]() }) {
        super.init(name: "p", builder)
        self.contents = [content]
    }
}

public class div: HTMLNode {
    public init(@ArrayBuilder _ builder: () -> [HTMLNode] = { [HTMLNode]() }) {
        super.init(name: "div", builder)
    }
}

public class span: HTMLNode {
    public init(@ArrayBuilder _ builder: () -> [HTMLNode] = { [HTMLNode]() }) {
        super.init(name: "span", builder)
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
    public init() {
        super.init(name: "noscript")
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
    public init() {
        super.init(name: "a")
    }
}
public class abbr: HTMLNode {
    public init() {
        super.init(name: "abbr")
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
    public init() {
        super.init(name: "b")
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
    public init() {
        super.init(name: "math")
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
    public init() {
        super.init(name: "nav")
    }
}
public class object: HTMLNode {
    public init() {
        super.init(name: "object")
    }
}
public class ol: HTMLNode {
    public init() {
        super.init(name: "ol")
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
    public init() {
        super.init(name: "u")
    }
}
public class ul: HTMLNode {
    public init() {
        super.init(name: "ul")
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
    public init() {
        super.init(name: "text")
    }
}
