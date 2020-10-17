//
//  GraphProtocol.swift
//  
//
//  Created by lonnie on 2020/10/17.
//

import Foundation
protocol GraphProtocol: StringConvertable {
    
    var vertexCount: Int {get}
    
    var edgeCount: Int  {get}
    
    var adj: [[Int]]  {get}
    
    func addEdge(_ v: Int, _ w: Int)
    
    init(_ vertexCount: Int)
}

extension GraphProtocol {
    
    func validateVertex(_ v: Int) -> Bool {
        if v < 0 || v >= vertexCount {return false}
        return true
    }
    
    func adj(_ v: Int) -> [Int] {
        if !validateVertex(v) {return []}
        return adj[v]
    }
    
    func averageDegree() -> Int {
        return 2 * edgeCount / vertexCount
    }
    
    func numberOfSelfLoops() -> Int {
        var count = 0
        for v in 0..<vertexCount {
            for w in adj(v) {
                if v == w { count += 1 }
            }
        }
        return count / 2
    }
    
    /// Read from URL
    ///
    /// - Parameter url: File URL
    /// - Throws: exception
    init(_ url: URL) throws {
        let text = try String(contentsOf: url)
        try self.init(text)
    }
    
    static func fromString(_ string: String) throws -> Self {
        try self.init(string)
    }
    
    func toString() -> String {
        var s = "\(vertexCount)\n\(edgeCount)\n"
        for v in 0..<vertexCount {
            for w in adj[v] {
                if v < w {
                    s.append("\(v) \(w)\n")
                }
            }
        }
        return s
    }
    
    init(_ text: String) throws {
        let contents = text.components(separatedBy: .newlines)
        if !contents.isEmpty, let v = Int(contents[0]) {
            self.init(v)
            for i in 2..<contents.count {
                let items = contents[i].components(separatedBy: .whitespacesAndNewlines).filter({!$0.isEmpty})
                if items.count == 2 {
                    addEdge(Int(items[0])!, Int(items[1])!)
                }
            }
        } else {
            self.init(0)
        }
    }
    
}