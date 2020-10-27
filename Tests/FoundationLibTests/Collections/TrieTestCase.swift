
//
//  TrieTestCase.swift
//
//
//  Created by lonnie on 2020/10/17.
//

import Foundation
import XCTest
@testable import FoundationLib
final class TrieTestCase: XCTestCase {
    
    func testTrie() throws {
        let trie = Trie<Character, Void>(.lowercasedAlphabets)
        try DebugLogger.default.measure {
            for _ in 0..<10000 {
                let word = Array(count: 10, in: .lowercasedAlphabets)
                try trie.insert(word)
                try trie.search(word).assert.equal(true)
                try trie.startsWith(word).assert.equal(true)
                
            }
        }
    }
    
    func testInsertNumberWithTrie() throws {
        let trie = Trie<Character, Int>(.numbers)
        try DebugLogger.default.measure(description: "Insert number with Trie") {
            for i in 0..<100000 {
                try trie.insert(i.description, i)
                try trie.value(i.description).assert.equal(i)
            }
        }
    }
    
    func testInsertNumberWithDictionary() throws {
        var dic: [String: Int] = [:]
        try DebugLogger.default.measure(description: "Insert number with Dictionary") {
            for i in 0..<100000 {
                dic[i.description] = i
                dic[i.description].assert.equal(i)
            }
        }
    }
    
    func testInsertNumberWithRedBlackTree() throws {
        let redBlackTree = RedBlackTree<String, Int>()
        try DebugLogger.default.measure(description: "Insert number with RebBlackTree") {
            for i in 0..<100000 {
                redBlackTree[i.description] = i
                redBlackTree[i.description].assert.equal(i)
            }
        }
    }
    
    func testTrie3() {
        let trie = Trie<Character, Int>(.numbers)
        let key = "12345"
        trie[key] = 12345
        trie[key].assert.equal(12345)
        trie[key] = 89893
        trie[key].assert.equal(89893)
        trie[key] = nil
        XCTAssert(trie[key] == nil)
    }
    
    func testScanProject() throws {
        let trie = Trie<Character, Int>(.numbers + .alphabets + ["_"])
        let basePath = projectPath()
        let subpaths = FileManager.default.subpaths(atPath: basePath) ?? []
        for path in subpaths {
            let filePath = basePath / path
            if FileManager.default.fileExists(atPath: filePath) && filePath.hasSuffix(".swift") {
                let strings = try String(contentsOf: .init(fileURLWithPath: filePath))
                var elements: [Character] = []
                for char in strings {
                    if trie.contains(char) {
                        elements.append(char)
                    } else {
                        if !elements.isEmpty {
                            let value = trie[elements] ?? 0
                            trie[elements] = value + 1
                            elements.removeAll()
                        }
                    }
                }
            }
        }
        let keys = trie.allKeys().map { String($0) }
        var dictionary: [String: Int] = [:]
        
        for key in keys {
            dictionary[key] = trie[key] ?? 0
        }
        let url = URL(fileURLWithPath: dataPath() / "trie")
        try dictionary.toData().write(to: url)
        let newDictionary = try [String: Int].fromData(Data(contentsOf: url))
        let newTrie = Trie<Character, Int>(.numbers + .alphabets + ["_"])
        try DebugLogger.default.measure(description: "Create trie") {
            for (key, value) in newDictionary {
                newTrie[key] = value
            }
        }
        try DebugLogger.default.measure(description: "Get all keys without mapping") {
            _ = trie.allKeys()
        }
        try DebugLogger.default.measure(description: "Get all keys") {
            let newKeys = trie.allKeys().map({ String($0) })
            newKeys.assert.equal(keys)
        }
        
        try DebugLogger.default.measure(description: "Get all keys") {
            for key in keys {
                trie[key].assert.equal(newTrie[key] ?? 0)
            }
        }
        
        try DebugLogger.default.measure(description: "Get keys start with a-z") {
            for item in [Character].lowercasedAlphabets {
                let keys = trie.allKeys(startsWith: [item]).map({String($0)})
                keys.forEach { (key) in
                    trie[key]?.assert.notNil()
                }
            }
            
        }
    }
}
