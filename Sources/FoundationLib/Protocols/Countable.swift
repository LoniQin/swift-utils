//
//  Countable.swift
//  
//
//  Created by lonnie on 2020/9/20.
//

import Foundation
public protocol Countable {
    
    var count: Int { get }
    
}

extension Countable {
    
    public var isEmpty: Bool {
        count == 0
    }
    
}
