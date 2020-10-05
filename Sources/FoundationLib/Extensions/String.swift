//
//  String.swift
//
//
//  Created by lonnie on 2020/8/19.
//

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
