//
//  HTMLNode.swift
//  
//
//  Created by lonnie on 2020/11/17.
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
    
    open override var description: String {
        toHTML(level: 0)
    }
    
}

// Chained methods
public extension HTMLNode {
    func id(_ value: String) -> Self {
        attributes["id"] = value
        return self
    }
    
    func `class`(_ value: String) -> Self {
        attributes["class"] = value
        return self
    }
    
    func href(_ value: String) -> Self {
        attributes["href"] = value
        return self
    }
    
    func src(_ value: String) -> Self {
        attributes["src"] = value
        return self
    }
}
