//
//  NumberConvertable.swift
//  
//
//  Created by lonnie on 2020/8/22.
//

import Foundation

public protocol NumberConvertable {
    
    var int: Int { get }
    
    var uint: UInt { get }

    var double: Double { get }

    var float: Float { get }
}

public extension Numeric {
    
    var hundred: Self {
        self * Self(exactly: 100)!
    }
    
    var thouthand: Self {
        self * Self(exactly: 1000)!
    }
    
    var million: Self {
        self * Self(exactly: 1000000)!
    }
    
    var billion: Self {
        self * Self(exactly: 1000000000)!
    }
    
}
