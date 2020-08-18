//
//  Double+Extension.swift
//
//
//  Created by lonnie on 2020/8/19.
//
import UIKit

public extension Optional where Wrapped == Double {
    
    var unwrapped: Double {
        switch self {
        case .some(let value):
            return value
        default:
            return 0
        }
    }
    
}
