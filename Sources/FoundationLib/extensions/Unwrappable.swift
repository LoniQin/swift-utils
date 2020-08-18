//
//  Unwrappable.swift
//  
//
//  Created by lonnie on 2020/8/19.
//

import Foundation

public protocol Unwrappable {
    
    static var defaultValue: Self { get }
    
}

extension Double: Unwrappable {
    
    public static var defaultValue: Double {
        return 0
    }
    
}

extension Int: Unwrappable {
    
    public static var defaultValue: Int {
        return 0
    }
    
}

extension Optional where Wrapped: Unwrappable {
    
    var unwrapped: Wrapped {
        switch self {
        case .some(let string):
            return string
        default:
            return Wrapped.defaultValue
        }
    }
    
}
