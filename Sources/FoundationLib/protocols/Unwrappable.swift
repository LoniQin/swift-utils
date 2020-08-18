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
    
    public static var defaultValue: Double {  0 }
    
}

extension Int: Unwrappable {
    
    public static var defaultValue: Int { 0 }
    
}

extension String: Unwrappable {
    
    public static var defaultValue: String { "" }
    
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
