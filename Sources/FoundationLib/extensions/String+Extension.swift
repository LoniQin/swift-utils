//
//  String+Extension.swift
//
//
//  Created by lonnie on 2020/8/19.
//

public extension Optional where Wrapped == String {
    
    var unwrapped: String {
        switch self {
        case .some(let string):
            return string
        default:
            return ""
        }
    }
    
}

public func / (lhs: String, rhs: String) -> String {
    return "\(lhs)/\(rhs)"
}
