//
//  Unwrappable.swift
//  
//
//  Created by lonnie on 2020/8/19.
//

import Foundation

public protocol Unwrappable {
    
    init()
    
}

extension Double: Unwrappable {}

extension Int: Unwrappable {}

extension Float: Unwrappable {}

extension UInt: Unwrappable {}

extension String: Unwrappable {}

extension Optional where Wrapped: Unwrappable {
    
    public var unwrapped: Wrapped {
        switch self {
        case .some(let string):
            return string
        default:
            return Wrapped()
        }
    }
    
}
