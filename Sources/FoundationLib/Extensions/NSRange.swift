//
//  NSRange.swift
//  
//
//  Created by lonnie on 2020/10/25.
//

import Foundation
public extension NSRange {
    
    var isValid: Bool {
        location != NSNotFound
    }
    
}
