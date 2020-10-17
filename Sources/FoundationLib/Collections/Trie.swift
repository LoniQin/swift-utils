//
//  Trie.swift
//  
//
//  Created by lonnie on 2020/10/17.
//
import Foundation
public class Trie<Element: Hashable & Equatable, Content> {
    
    struct Node {
        
        var positions: [UInt32]
        
        var isEnd: Bool
        
        var content: Content? = nil
        
    }
    
    private var templateNode: Node
    
    var nodes: [Node] = []
    
    private var elements: [Element] = []
    
    private var elementIndex: [Element: Int] = [:]
    
    public subscript(key: [Element]) -> Content? {
        get {
            try? value(key)
        }
        
        set {
            try? insert(key, newValue)
        }
    }

    public init(_ elements: [Element]) {
        templateNode = Node(positions: [UInt32](repeating: 0, count: elements.count), isEnd: false)
        nodes.append(templateNode)
        self.elements = elements
        for item in elements.enumerated() {
            self.elementIndex[item.element] = item.offset
        }
    }
    
    public func insert(_  sequence: [Element], _ content: Content? = nil) throws {
        var sequence = sequence
        if !sequence.isEmpty { try insert(0, &sequence, 0, content) }
    }
    
    private func insert(_ index: Int, _  sequence: inout [Element], _ i: Int, _ content: Content? = nil) throws {
        let position: Int = try elementIndex.get(sequence[i])
        if nodes[index].positions[position] == 0 {
            nodes[index].positions[position] = UInt32(nodes.count)
            nodes.append(templateNode)
        }
        if i != sequence.count - 1 {
            try insert(Int(nodes[index].positions[position]), &sequence, i + 1, content)
        } else {
            nodes[Int(nodes[index].positions[position])].isEnd = true
            nodes[Int(nodes[index].positions[position])].content = content
        }
    }
    
    public func search(_ sequence: [Element]) throws -> Bool {
        var i = 0, index = 0, position = 0
        while true {
            position = try elementIndex.get(sequence[i])
            if nodes[index].positions[position] == 0 { return false }
            if i != sequence.count - 1 {
                i += 1
                index = Int(nodes[index].positions[position])
            } else {
                return nodes[Int(nodes[index].positions[position])].isEnd
            }
        }
    }
    
    public func value(_ sequence: [Element]) throws -> Content {
        var i = 0, index = 0, position = 0
        while true {
            position = try elementIndex.get(sequence[i])
            if nodes[index].positions[position] == 0 { throw FoundationError.nilValue }
            if i != sequence.count - 1 {
                i += 1
                index = Int(nodes[index].positions[position])
            } else {
                if let content = nodes[Int(nodes[index].positions[position])].content {
                    return content
                }
                throw FoundationError.nilValue
            }
        }
    }
    
    public func startsWith(_ sequence: [Element]) throws -> Bool {
        var i = 0, index = 0, position = 0
        while true {
            position = try elementIndex.get(sequence[i])
            if nodes[index].positions[position] == 0 { return false }
            if i != sequence.count - 1 {
                i += 1
                index = Int(nodes[index].positions[position])
            } else {
                return true
            }
        }
    }

}
