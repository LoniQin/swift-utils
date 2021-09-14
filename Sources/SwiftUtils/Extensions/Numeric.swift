//
//  Numeric.swift
//  
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
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
