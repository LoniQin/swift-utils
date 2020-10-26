//
//  String.swift
//
//
//  Created by lonnie on 2020/8/19.
//
import CoreFoundation
public extension String {
    
    func appendingPrefix(_ string: String) -> String {
        hasPrefix(string) ? self : string.appending(self)
    }

    func appendingSuffix(_ string: String) -> String {
        hasSuffix(string) ? self : self.appending(string)
    }
    
    func interpolation(_ arguments: CVarArg...) -> String {
        String(format: self, arguments: arguments)
    }
    
    init(radom count: Int, in sequence: [Character]) throws {
        if sequence.isEmpty  { throw FoundationError.outOfBounds }
        self.init()
        for _ in 0..<count {
            self.append(sequence[Int.random(in: 0..<sequence.count)])
        }
    }
    
    func substring(from: Int? = nil, to: Int? = nil) -> Substring {
        if let to = to, let from = from {
            return self[index(startIndex, offsetBy: from)..<index(startIndex, offsetBy: to)]
        } else if let from = from {
            return self[index(startIndex, offsetBy: from)...]
        } else if let to = to {
            return self[..<index(startIndex, offsetBy: to)]
        } else {
            return self[self.startIndex..<self.endIndex]
        }
    }
    
    func replacingPercentEncoding() -> String {
        CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault, self as CFString, "" as CFString) as String
    }
    
    func toRegularExpression(options: NSRegularExpression.Options = []) throws -> NSRegularExpression {
        try NSRegularExpression(pattern: self, options: options)
    }
    
}

extension String: NumberConvertable {
    
    public var int: Int { Int(self) ?? .init() }
    
    public var uint: UInt { UInt(self) ?? .init() }
    
    public var double: Double { Double(self) ?? .init() }
    
    public var float: Float { Float(self) ?? .init() }
    
}

public func / (lhs: String, rhs: String) -> String {
    "\(lhs)/\(rhs)"
}

public func - (lhs: String, rhs: String) -> String {
    "\(lhs)-\(rhs)"
}

public func * (lhs: String, rhs: Int) -> String {
    Array(repeating: lhs, count: rhs).joined()
}

public func * (lhs: Int, rhs: String) -> String {
    rhs * lhs
}
